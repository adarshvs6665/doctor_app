import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_app/controllers/userController.dart';
import 'package:doctor_app/screens/login/login.dart';
import 'package:doctor_app/utils/constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final userController = Get.find<UserController>();
  late final userName;

  @override
  void initState() {
    super.initState();

    setState(() {
      userName = userController.user.value['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color.fromARGB(37, 44, 73, 255),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: kCyan,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: kDarkBlue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                   userName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.account_circle),
                        title: const Text('Edit Profile'),
                        onTap: () {
                          // Handle Edit Profile tap
                          print('tapped');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: const Text('Notifications'),
                        onTap: () {
                          // Handle Notifications tap
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip),
                        title: const Text('Privacy'),
                        onTap: () {
                          // Handle Privacy tap
                        },
                      ),
                      // Add more options as needed
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(kCyan),
                    ),
                    onPressed: () {
                      userController.clearUserDetails();
                      Get.off(LoginPage());
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: kDarkBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
