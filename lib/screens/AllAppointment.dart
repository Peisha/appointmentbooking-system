import 'dart:convert';

import 'package:chatapp/cells/trd_cell.dart';
import 'package:chatapp/components/appointment_card.dart';
import 'package:chatapp/screens/ListofCat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AllAppointment extends StatefulWidget {
  static const String id = 'allappointment';
  const AllAppointment({Key? key});

  @override
  State<AllAppointment> createState() => _AllAppointmentState();
}

class _AllAppointmentState extends State<AllAppointment> {
  var currentuser;
  var userinfo;

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = (prefs.getString('userdata') ?? '');
    var datas = (prefs.getString('userinfo') ?? '');

    currentuser = User.fromJson(jsonDecode(data.toString()));

    userinfo = json.decode(datas.toString());
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Appointments'),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('appointment').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) =>
                  AppointmentCard(doctor: snapshot.data!.docs[index].data()),
            );
          },
        ),
      ),
    );
    ;
  }
}
