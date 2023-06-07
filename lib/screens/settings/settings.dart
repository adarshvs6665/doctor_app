import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_app/controllers/userController.dart';
import 'package:doctor_app/screens/login/login.dart';
import 'package:doctor_app/utils/constants.dart';

class SettingsPage extends StatelessWidget {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
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
                        ListTile(
                          leading: const Icon(Icons.subscriptions),
                          title: const Text('Subscription'),
                          onTap: () {},
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
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kCyan),
                      ),
                      onPressed: () {
                        userController.clearUserDetails();
                        Get.off(LoginPage());
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                            color: kDarkBlue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
