import 'package:chatapp/cells/trd_cells.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllPatient extends StatefulWidget {
  static const String id = 'AllPatient';
  final String usertype;
  const AllPatient({Key? key, required this.usertype});

  @override
  State<AllPatient> createState() => _AllPatientState();
}

class _AllPatientState extends State<AllPatient> {
  var userData = {};
  int postLen = 0;
  var patientlst = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('users')
          .where('usertype', isEqualTo: 'patient')
          .get();

      postLen = postSnap.docs.length;

      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Patient')),
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
    );
  }
}
