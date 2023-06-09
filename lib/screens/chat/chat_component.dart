import 'dart:convert';
import 'package:doctor_app/screens/patient/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_app/controllers/userController.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class ChatComponent extends StatefulWidget {
  final String chatName;
  final String chatId;
  final String chatType;
  final String recipientId;

  const ChatComponent(
      {Key? key,
      required this.chatName,
      required this.chatId,
      required this.chatType,
      required this.recipientId})
      : super(key: key);

  @override
  _ChatComponentState createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  final userController = Get.find<UserController>();
  late String doctorIdSelf;
  late String userName;

  List<Map<String, String>> chatMessages = [];

  IO.Socket? socket;
  TextEditingController messageController = TextEditingController();

  void sendGroupMessage(userId, name) {
    // final String userId = userController.user.value['doctorId'];
    String message = messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        // chatMessages.add({"userId":userId,"message": message, "name": name});
        messageController.clear();
      });

      // Emit the message to the server
      socket?.emit("sendGroupMessage", {
        "chatId": widget.chatId,
        "userId": userId,
        "message": message,
        "name": name,
      });
    }
  }

  Future<void> fetchChatMessages() async {
    final url = '${baseUrl}/fetch-chat-messages';

    final queryParameters = {
      'chatId': widget.chatId,
    };

    final response = await http
        .get(Uri.parse(url).replace(queryParameters: queryParameters));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> chatsArray = responseData['data'];

      final parsedChats = chatsArray.map((chat) {
        return {
          'message': chat['message'].toString(),
          'userId': chat['userId'].toString(),
          'name': chat['name'].toString(),
        };
      }).toList();
      // print(chatsArray);
      // print("##############################################################");
      setState(() {
        chatMessages = parsedChats;
      });
    }
  }

  void sendDoctorMessage(userId, name) {
    // final String userId = userController.user.value['doctorId'];
    String message = messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        // chatMessages.add({"userId":userId,"message": message, "name": name});
        messageController.clear();
      });

      // Emit the message to the server
      socket?.emit("sendDoctorMessage", {
        "chatId": widget.chatId,
        "userId": userId,
        "message": message,
        "name": name,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // print(doctorIdSelf);

    if (widget.chatType == 'group') {
      connectToGroupSocket();
    } else {
      connectToDoctorSocket();
    }

    fetchChatMessages();
    setState(() {
      doctorIdSelf = userController.user.value['doctorId'];
      userName = userController.user.value['name'];
    });
  }

  @override
  void dispose() {
    socket?.dispose();
    super.dispose();
  }

  Future<void> connectToGroupSocket() async {
    // Replace the URL with your Socket.IO server URL
    socket = IO.io('${socketURL}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket!.onConnect((_) {
      print('Connected to Socket.IO server');
      // Emit an event or perform any necessary actions upon connection
      // For example, you can emit an event to join the group chat room
      socket!.emit('joinGroupChat', {'chatId': widget.chatId});
    });

    socket!.onDisconnect((_) => print('Disconnected from Socket.IO server'));

    // Listen for incoming chat messages
    socket!.on('newGroupMessage', (data) {
      // Handle the incoming message data and update the chatMessages list
      setState(() {
        chatMessages.add({
          "message": data["message"],
          "name": data["name"],
          "userId": data["userId"]
        });
      });
    });
  }

  Future<void> connectToDoctorSocket() async {
    // Replace the URL with your Socket.IO server URL
    socket = IO.io('${socketURL}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket!.onConnect((_) {
      // print('Connected to Socket.IO server');
      // Emit an event or perform any necessary actions upon connection
      // For example, you can emit an event to join the group chat room
      socket!.emit('joinDoctorChat', {'chatId': widget.chatId});
    });

    socket!.onDisconnect((_) => print('Disconnected from Socket.IO server'));

    // Listen for incoming chat messages
    socket!.on('newDoctorMessage', (data) {
      // Handle the incoming message data and update the chatMessages list
      setState(() {
        chatMessages.add({
          "message": data["message"],
          "name": data["name"],
          "userId": data["userId"]
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String chatName = widget.chatName;
    return Scaffold(
      appBar: AppBar(
        title: Text(chatName),
        backgroundColor: const Color.fromARGB(37, 44, 73, 255),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextButton(
              onPressed: () {
                Get.to(ProfilePage(
                    patientId: widget.recipientId, chatName: widget.chatName));
              },
              style: TextButton.styleFrom(
                  backgroundColor: kCyan,
                  primary: kDarkBlue,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
              child: const Text("View profile"),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg.jpeg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final message = chatMessages[index];
                  final isUserMessage = message['userId'] == doctorIdSelf;
                  final messageContent = message['message'];
                  if (!isUserMessage) {
                    final name = message['name'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 4.0),
                            const Icon(
                              Icons.account_circle,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              name ?? '',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.75,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              messageContent!,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 6, 57, 112),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'You',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 4.0),
                              Icon(
                                Icons.account_circle,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4.0),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.fromLTRB(
                                    8.0, 4.0, 8.0, 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 4.0),
                                    Text(
                                      messageContent!,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]);
                  }
                },
              ),
            ),
            Container(
              color: const Color.fromARGB(37, 44, 73, 255),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your message',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () => {
                      widget.chatType == 'group'
                          ? sendGroupMessage(doctorIdSelf, userName)
                          : sendDoctorMessage(doctorIdSelf, userName)
                    },
                    child: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
