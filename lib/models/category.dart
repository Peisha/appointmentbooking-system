import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String pic;
  final String title;

  Category({
    required this.pic,
    required this.title,
  });

  static Category fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Category(
      pic: snapshot["pic"],
      title: snapshot["title"],
    );
  }

  Map<String, dynamic> toJson() => {
        "pic": pic,
        "title": title,
      };
}
