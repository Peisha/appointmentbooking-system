import 'package:chatapp/screens/DoctorAppointment.dart';
import 'package:chatapp/screens/DoctorProfile.dart';
import 'package:chatapp/screens/Profile_Screen.dart';
import 'package:flutter/material.dart';

// import 'package:socialmedia/screens/feedScreen.dart';
import 'package:chatapp/screens/Admin_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/screens/chat_screen.dart';

class DoctorNavigation extends StatefulWidget {
  static const String id = 'NavigagtionDoctor_screen';

  @override
  State<DoctorNavigation> createState() => _DoctorNavigationState();
}

class _DoctorNavigationState extends State<DoctorNavigation> {
  int _selectedIndex = 0;

  List<Widget> lstWidget = [
    DoctorAppointment(),
    ChatScreen(),
    Profile_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 228, 228, 228),
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color.fromARGB(255, 95, 95, 95),
        elevation: 10,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: 'Appointments',
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
