import 'package:chatapp/cells/trd_cell.dart';
import 'package:chatapp/cells/trd_cells.dart';
import 'package:chatapp/components/donationcard.dart';
import 'package:chatapp/responsive/navigation_drawer.dart';
import 'package:chatapp/screens/AddDoctor.dart';
import 'package:chatapp/screens/AddDonation.dart';
import 'package:chatapp/screens/Admin_Screen.dart';
import 'package:chatapp/screens/ListofCat.dart';
import 'package:chatapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Donation extends StatefulWidget {
  static const String id = 'Donation';
  const Donation({Key? key});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
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
      appBar: AppBar(
          title: const Text('All Donation'),
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
                Navigator.pushNamed(context, AddDonation.id);
              },
            )
          ]),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('donation').snapshots(),
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
                child: DonationCard(doctor: snapshot.data!.docs[index].data()),
              ),
            );
          },
        ),
      ),
    );
  }
}
