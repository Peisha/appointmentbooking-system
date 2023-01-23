import 'package:chatapp/components/LabeTestCard.dart';
import 'package:chatapp/responsive/navigation_drawer.dart';
import 'package:chatapp/screens/AddLabTest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllTest extends StatefulWidget {
  static const String id = 'Alltest';

  const AllTest({Key? key});

  @override
  State<AllTest> createState() => _AllTestState();
}

class _AllTestState extends State<AllTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('All Report'),
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
                Navigator.pushNamed(context, AddLabTest.id);
              },
            )
          ]),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('report').snapshots(),
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
                child: LabTestCard(allinfo: snapshot.data!.docs[index].data()),
              ),
            );
          },
        ),
      ),
    );
    ;
  }
}
