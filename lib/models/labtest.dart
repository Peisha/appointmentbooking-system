import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LabTest {
  final String id;
  final String pic;
  final String email;

  final String name;
  final DateTime bookdate;

  LabTest(
      {required this.pic,
      required this.email,
      required this.name,
      required this.bookdate,
      required this.id
      });

  static LabTest fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return LabTest(
      pic: snapshot["pic"],
      email: snapshot["email"],
      name: snapshot["name"],
      bookdate: snapshot["bookdate"],
      id: snapshot["id"],

    );
  }

  Map<String, dynamic> toJson() => {
        "pic": pic,
        "email": email,
        "name": name,
        "bookdate": bookdate,
        "id": id,

      };
}
