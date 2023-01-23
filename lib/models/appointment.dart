import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String doctor;
  final String title;
  final DateTime bookdate;
  final String time;
  final bool status;
  final Object category;
  final String patient;
  final String patientemail;
  final String docpic;
  final String patientpic;

  Appointment(
      {required this.doctor,
      required this.title,
      required this.bookdate,
      required this.status,
      required this.time,
      required this.category,
      required this.patient,
      required this.patientemail,
      required this.docpic,
      required this.patientpic});

  static Appointment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Appointment(
        doctor: snapshot["doctor"],
        title: snapshot["title"],
        bookdate: snapshot["bookdate"],
        status: snapshot["status"],
        time: snapshot["time"],
        category: snapshot["category"],
        patient: snapshot["patient"],
        patientemail: snapshot["patientemail"],
        docpic: snapshot["docpic"],
        patientpic: snapshot['patientpic']);
  }

  Map<String, dynamic> toJson() => {
        "doctor": doctor,
        "title": title,
        "bookdate": bookdate,
        "status": status,
        'time': time,
        'category': category,
        'patient': patient,
        'patientemail': patientemail,
        'docpic': docpic,
        'patientpic': patientpic
      };
}
