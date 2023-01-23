import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/models/user.dart' as model;
import 'package:chatapp/models/appointment.dart' as app;

import 'package:chatapp/resources/storage_methods.dart';
import 'package:chatapp/models/category.dart' as catmodel;
import 'package:chatapp/models/lstscedule.dart' as lstscedule;
import 'package:chatapp/models/donation.dart' as donation;
import 'package:chatapp/models/labtest.dart' as labtest;

class AddMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> addcat({
    required String title,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (file != null) {
        // registering user in auth with email and password

        String pic = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        catmodel.Category __category = catmodel.Category(
          title: title,
          pic: pic,
        );

        // adding user in our database
        await _firestore.collection("category").add(__category.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // add doctor

  Future<String> AddDoctor(
      {required String email,
      required String password,
      required String name,
      required Uint8List file,
      required dynamic cic,
      required dynamic dule,
      required int phonenumber,
      required String age,
      required String gender}) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String pic = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User _user = model.User(
          name: name,
          uid: cred.user!.uid,
          pic: pic,
          email: email,
          bio: '',
          followers: [],
          gender: gender,
          patient: [],
          bloodtype: 'A+',
          age: age,
          usertype: 'doctor',
          category: cic,
          scedule: json.encode(dule),
          phonenumber: phonenumber,
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> BookAppointment(
      {required String doctor,
      required String title,
      required DateTime bookdate,
      required bool status,
      required String time,
      required Object category,
      required String patient,
      required String patientemail,
      required String docpic,
      required String patientpic}) async {
    String res = "Some error Occurred";
    try {
      if (doctor.isNotEmpty || title.isNotEmpty) {
        // registering user in auth with doctor and password

        app.Appointment _appointment = app.Appointment(
            title: title,
            bookdate: bookdate,
            status: status,
            doctor: doctor,
            time: time,
            category: category,
            patient: patient,
            patientemail: patientemail,
            docpic: docpic,
            patientpic: patientpic);

        // adding user in our database
        await _firestore
            .collection("appointment")
            .doc()
            .set(_appointment.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> AddDonation(
      {required String email,
      required String name,
      required Uint8List file,
      required String bloodtype,
      required String gender,
      required int phonenumber,
      required String age}) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || name.isNotEmpty || file != null) {
        // registering user in auth with email and password

        String pic = await StorageMethods()
            .uploadImageToStorage('donationuser', file, true);

        donation.Donation _user = donation.Donation(
            name: name,
            pic: pic,
            email: email,
            gender: gender,
            bloodtype: bloodtype,
            age: age,
            phonenumber: phonenumber);

        // adding user in our database
        await _firestore.collection("donation").add(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> AddReport({
    required String email,
    required String name,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || name.isNotEmpty || file != null) {
        // registering user in auth with email and password

        String pic =
            await StorageMethods().uploadImageToStorage('report', file, true);

        final docref = _firestore.collection('reports').doc();
        String postid = docref.id;

        labtest.LabTest _user = labtest.LabTest(
            id: postid,
            name: name,
            pic: pic,
            email: email,
            bookdate: DateTime.now());

        // adding user in our database
        await _firestore.collection("report").add(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
