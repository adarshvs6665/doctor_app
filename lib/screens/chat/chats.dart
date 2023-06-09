import 'package:doctor_app/controllers/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_app/models/Chats.dart';
import 'package:doctor_app/screens/chat/chat_component.dart';
import 'dart:convert';
import '../../utils/constants.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<dynamic> chatList = [];
  final userController = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
    fetchChatList();
  }

  Future<void> fetchChatList() async {
    const url = '$baseUrl/chats';
    final doctorId = userController.user.value['doctorId'];

    final headers = {'Content-Type': 'application/json'};
    final queryParameters = {
      'doctorId': doctorId,
    };

    final response = await http.get(
        Uri.parse(url).replace(queryParameters: queryParameters),
        headers: headers);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> chatData = responseData['data'];
      final List<Chats> chats =
          chatData.map((json) => Chats.fromJson(json)).toList();

      setState(() {
        chatList = responseData['data'];
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: const Color.fromARGB(37, 44, 73, 255),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: chatList.length > 0
              ? ListView.builder(
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    final chat = chatList[index];
                    final chatName = chat['chatName'];
                    final chatType = chat['chatType'];
                    final chatId = chat['chatId'];
                    final recipientId = chat['recipientId'];

                    return Card(
                      color: kDarkBlue,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5.0),
                      child: ListTile(
                        leading: chatType == 'group'
                            ? const Icon(
                                Icons.group_rounded,
                                size: 40,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.account_circle,
                                size: 40,
                                color: Colors.blue,
                              ),
                        title: Text(chatName),
                        subtitle: Text(chatType),
                        onTap: () {
                          // Handle chat item tap event
                          // Navigate to chat details page or perform any desired action
                          Get.to(ChatComponent(
                              chatId: chatId,
                              chatName: chatName,
                              chatType: chatType,
                              recipientId: recipientId));
                        },
                      ),
                    );
                  },
                )
              : Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.thumb_down_rounded,
                        color: kCyan,
                        size: 80.0,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Nothing to show!',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
