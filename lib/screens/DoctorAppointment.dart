import 'dart:convert';

import 'package:chatapp/components/appointment_card.dart';
import 'package:chatapp/components/pappointment_card.dart';
import 'package:chatapp/screens/ListofCat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class DoctorAppointment extends StatefulWidget {
  static const String id = 'Doctorappointment';
  const DoctorAppointment({Key? key});

  @override
  State<DoctorAppointment> createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  var currentuser;
  var userinfo;
  bool isloading = true;

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = (prefs.getString('userdata') ?? '');
    var datas = (prefs.getString('userinfo') ?? '');

    currentuser = User.fromJson(jsonDecode(data.toString()));

    userinfo = json.decode(datas.toString());

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isloading) Text('...loading');
    return Scaffold(
      appBar: AppBar(title: const Text('All Appointments')),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('appointment')
              .where('doctor', isEqualTo: currentuser?.email)
              .snapshots(),
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
                  AppointmentCard0(doctor: snapshot.data!.docs[index].data()),
            );
          },
        ),
      ),
    );
    ;
  }
}
