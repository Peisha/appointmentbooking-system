import 'package:chatapp/screens/Profile_Screen.dart';
import 'package:flutter/material.dart';

// import 'package:socialmedia/screens/feedScreen.dart';
import 'package:chatapp/screens/Admin_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DrawerNavigation extends StatefulWidget {
  static const String id = 'NavigagtionDrawer_screen';

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  int _selectedIndex = 0;

  List<Widget> lstWidget = [
    Admin_Screen(),
    ChatScreen(),
    Profile_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        elevation: 10,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            label: 'profile',
          ),
        ],
      ),
      body: lstWidget[_selectedIndex],
    );
  }
}
