import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:doctor_app/controllers/userController.dart';
import 'package:doctor_app/screens/chat/chats.dart';
import 'package:doctor_app/screens/settings/settings.dart';
import 'package:doctor_app/utils/constants.dart';
import 'package:doctor_app/screens/chat/chat_component.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  static List<Widget> _pages = [
    // HomePage(),
    // ExplorePage(),
    // ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget;
    if (_selectedIndex == 0) {
      bodyWidget = ChatListPage();
    } else if (_selectedIndex == 1) {
      bodyWidget = ChatListPage();
    } else {
      bodyWidget = SettingsPage();
    }

    return Scaffold(
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color.fromARGB(37, 44, 73, 255),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _selectedIndex == 0 ? kCyan : null),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: _selectedIndex == 1 ? kCyan : null),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.settings, color: _selectedIndex == 2 ? kCyan : null),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
