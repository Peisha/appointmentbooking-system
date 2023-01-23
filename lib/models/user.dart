import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/models/scedule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String email;
  final String uid;
  final String pic;
  final String name;
  final String bio;
  final String bloodtype;
  final String age;

  final List followers;
  final List patient;
  final String usertype;
  final Object? category;
  final String? scedule;
  final String? gender;
  final int? phonenumber;
  const User(
      {required this.name,
      required this.uid,
      required this.pic,
      required this.email,
      required this.bio,
      required this.followers,
      required this.patient,
      required this.bloodtype,
      required this.age,
      required this.usertype,
      this.category,
      this.scedule,
      this.gender,
      this.phonenumber
      });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      name: snapshot["name"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      pic: snapshot["pic"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      patient: snapshot["patient"],
      age: snapshot["age"],
      bloodtype: snapshot["bloodtype"],
      usertype: snapshot["usertype"],
      category: snapshot["category"],
      scedule: snapshot["scedule"],
      gender: snapshot["gender"],
      phonenumber: snapshot["phonenumber"],

    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
