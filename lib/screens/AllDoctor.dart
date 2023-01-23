import 'package:chatapp/cells/trd_cell.dart';
import 'package:chatapp/responsive/navigation_drawer.dart';
import 'package:chatapp/screens/ListofCat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllDoctor extends StatefulWidget {
  static const String id = 'AllDoctor';
  final String usertype;
  const AllDoctor({Key? key, required this.usertype});

  @override
  State<AllDoctor> createState() => _AllDoctorState();
}

class _AllDoctorState extends State<AllDoctor> {
  var userData = {};
  int postLen = 0;
  var patientlst = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('All Doctor'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, DrawerNavigation.id);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Perform action
                Navigator.pushNamed(context, ListofCat.id);
              },
            )
          ]),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('usertype', isEqualTo: 'doctor')
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
                child: TrdCell(doctor: snapshot.data!.docs[index].data()),
              ),
            );
          },
        ),
      ),
    );
  }
}
