import 'dart:convert';

import 'package:doctor_app/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_app/controllers/userController.dart';
import 'package:doctor_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, required this.patientId, required this.chatName});

  final String patientId;
  final String chatName;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

// /fetch-user-profile
class _ProfilePageState extends State<ProfilePage> {
  final userController = Get.find<UserController>();
  late final userDetails;
  late Future<Map<String, dynamic>> _fetchUserDetailsFuture;

  Future<Map<String, dynamic>> fetchUserProfile() async {
    const url = '$baseUrl/fetch-user-profile';

    final queryParameters = {'userId': widget.patientId};

    final response = await http
        .get(Uri.parse(url).replace(queryParameters: queryParameters));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final Map<String, dynamic> userDetailsFetched = responseData['data'];
      // setState(() {
      //   userDetails = userDetailsFetched;
      // });

      return userDetailsFetched;
    } else {
      // Handle error
      return {};
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchUserProfile();
    _fetchUserDetailsFuture = fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: const Color.fromARGB(37, 44, 73, 255),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: _fetchUserDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While data is being fetched, show a loading indicator
                return Center(
                  child: Container(
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
                );
              } else if (snapshot.hasError) {
                // If there's an error while fetching data, display an error message
                return const Center(child: Text('Error fetching user details'));
              } else {
                // Data has been fetched successfully, access it using snapshot.data
                final userDetails = snapshot.data;

                // Continue building your UI using the fetched user details
                return Stack(
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
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userDetails!['name'],
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: kCyan,
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Mental Score",
                                                      style: TextStyle(
                                                          color: kCyan,
                                                          fontSize: 16)),
                                                  CustomText(
                                                    inputText:
                                                        userDetails['score']
                                                            .toString(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Condition",
                                                      style: TextStyle(
                                                          color: kCyan,
                                                          fontSize: 16)),
                                                  CustomText(
                                                    inputText:
                                                        userDetails['score'] >=
                                                                81
                                                            ? "Normal"
                                                            : "Cautious",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text("Tasks",
                                                style: TextStyle(
                                                    color: kCyan,
                                                    fontSize: 16)),
                                            const SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12.0),
                                              child: Text(
                                                userDetails['tasks'],
                                                style: const TextStyle(
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
                );
              }
            }));
  }
}
