import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:chatapp/screens/add_post_screen.dart';
// import 'package:chatapp/screens/feed_screen.dart';
import 'package:chatapp/screens/profile_screen.dart';
import 'package:chatapp/screens/Admin_Screen.dart';
import 'package:chatapp/screens/chat_screen.dart';
// import 'package:chatapp/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const Admin_Screen(),
  ChatScreen(),
  ChatScreen(),
  const Text('notifications'),
];
