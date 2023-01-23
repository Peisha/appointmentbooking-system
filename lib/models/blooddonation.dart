import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String bloodtype;
  final String created;

  Category({
    required this.bloodtype,
    required this.created,
  });

  static Category fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Category(
      bloodtype: snapshot["bloodtype"],
      created: snapshot["created"],
    );
  }

  Map<String, dynamic> toJson() => {
        "bloodtype": bloodtype,
        "created": created,
      };
}
