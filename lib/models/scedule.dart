import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:json_annotation/json_annotation.dart';

part 'scedule.g.dart';

@JsonSerializable()
class Scedule {
  final String weekday;
  final List<String> time;

  Scedule({
    required this.weekday,
    required this.time,
  });

  static Scedule fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Scedule(
      weekday: snapshot["weekday"],
      time: snapshot["time"],
    );
  }

 factory Scedule.fromJson(Map<String, dynamic> json) {
    return _$SceduleFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SceduleToJson(this);
}
