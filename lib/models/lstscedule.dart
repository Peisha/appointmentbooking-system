import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/models/scedule.dart';

class LstScedule {
  final List<Scedule> scedule;

  LstScedule({
    required this.scedule,
  });

  static LstScedule fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return LstScedule(
      scedule: snapshot["scedule"],
    );
  }

  Map<String, dynamic> toJson() => {
        "scedule": scedule,
      };
}
