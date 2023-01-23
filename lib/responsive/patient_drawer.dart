import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/screens/AllAppointment.dart';
import 'package:chatapp/screens/PatientAppointment.dart';
import 'package:chatapp/screens/Profile_Screen.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

// import 'package:socialmedia/screens/feedScreen.dart';
import 'package:chatapp/screens/Admin_Screen.dart';

import 'package:chatapp/screens/chat_screen.dart';

class PatientNavigation extends StatefulWidget {
  static const String id = 'NavigagtionPatient_screen';

  @override
  State<PatientNavigation> createState() => _PatientNavigationState();
}

class _PatientNavigationState extends State<PatientNavigation> {
  int _selectedIndex = 0;

  List<Widget> lstWidget = [
    HomeScreen(),
    ChatScreen(),
    PatientAppointment(),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: 'Appointment',
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
