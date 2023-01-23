import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  final String pic;
  final String email;
  final String bloodtype;
  final String name;
  final int phonenumber;
  final String age;
  final String gender;

  Donation(
      {required this.pic,
      required this.email,
      required this.bloodtype,
      required this.name,
      required this.phonenumber,
      required this.age,
      required this.gender
      });

  static Donation fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Donation(
      pic: snapshot["pic"],
      email: snapshot["email"],
      age: snapshot["age"],
      name: snapshot["name"],
      phonenumber: snapshot["phonenumber"],
      gender: snapshot["gender"],
      bloodtype: snapshot["bloodtype"]


    );
  }

  Map<String, dynamic> toJson() => {
        "pic": pic,
        "email": email,
        "age":age,
        "name":name,
        "phonenumber":phonenumber,
        "gender":gender,
        "bloodtype":bloodtype
      };
}
