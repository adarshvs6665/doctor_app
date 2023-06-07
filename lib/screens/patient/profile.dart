import 'package:doctor_app/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_app/controllers/userController.dart';
import 'package:doctor_app/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, required this.patientId, required this.chatName});

  final String patientId;
  final String chatName;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userController = Get.find<UserController>();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.chatName),
  //       backgroundColor: const Color.fromARGB(37, 44, 73, 255),
  //     ),
  //     body: Container(
  //       decoration: const BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage('assets/images/bg.jpeg'),
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       child: Center(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             const Padding(
  //               padding: EdgeInsets.all(16.0),
  //               child: CircleAvatar(
  //                 radius: 60,
  //                 backgroundColor: kCyan,
  //                 child: Icon(
  //                   Icons.person,
  //                   size: 80,
  //                   color: kDarkBlue,
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     ListTile(
  //                       leading: const Icon(Icons.account_circle),
  //                       title: const Text('Edit Profile'),
  //                       onTap: () {
  //                         // Handle Edit Profile tap
  //                         print('tapped');
  //                       },
  //                     ),
  //                     ListTile(
  //                       leading: const Icon(Icons.notifications),
  //                       title: const Text('Notifications'),
  //                       onTap: () {
  //                         // Handle Notifications tap
  //                       },
  //                     ),
  //                     ListTile(
  //                       leading: const Icon(Icons.privacy_tip),
  //                       title: const Text('Privacy'),
  //                       onTap: () {
  //                         // Handle Privacy tap
  //                       },
  //                     ),
  //                     ListTile(
  //                       leading: const Icon(Icons.subscriptions),
  //                       title: const Text('Subscription'),
  //                       onTap: () {},
  //                     ),
  //                     // Add more options as needed
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color.fromARGB(37, 44, 73, 255),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/meditation.png",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Spacer(),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: kDarkBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(32.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.chatName,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kCyan,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text("Mental Score",
                                            style: TextStyle(
                                                color: kCyan, fontSize: 16)),
                                        CustomText(
                                          inputText: "98",
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text("Condition",
                                            style: TextStyle(
                                                color: kCyan, fontSize: 16)),
                                        CustomText(
                                          inputText: "Normal",
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text("Tasks",
                                      style: TextStyle(
                                          color: kCyan, fontSize: 16)),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 12.0),
                                    child: Text(
                                      "Sleeping, swimming, talking to frineds, watching tv, jogging etc...",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            )),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
