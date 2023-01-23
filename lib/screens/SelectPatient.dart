import 'package:chatapp/cells/trd_cells.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SelectPatient extends StatefulWidget {
  const SelectPatient({Key? key});

  @override
  State<SelectPatient> createState() => _SelectPatientState();
}

class _SelectPatientState extends State<SelectPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('select Patient')),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('usertype', isEqualTo: 'patient')
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
              itemBuilder: (ctx, index) => Container(
                child: TrdCells(doctor: snapshot.data!.docs[index].data()),
              ),
            );
          },
        ),
      ),
    );;
  }
}