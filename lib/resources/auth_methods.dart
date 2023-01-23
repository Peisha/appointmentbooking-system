import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/models/user.dart' as model;
import 'package:chatapp/resources/storage_methods.dart';
import 'package:chatapp/models/category.dart' as catmodel;
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
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

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String bloodtype,
    required Uint8List file,
    required String gender,
    required String age
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          bloodtype.isNotEmpty ||
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
          patient: [],
          bloodtype: bloodtype,
          age: age,
          usertype: 'patient',
          category: '',
          gender:gender
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

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get()
            .then((doc) async {
          if (doc.docs.first.data()['usertype'] == 'admin') {
            res = "admin";
          }

          if (doc.docs.first.data()['usertype'] == 'patient') {
            res = "patient";
          }

          if (doc.docs.first.data()['usertype'] == 'doctor') {
            res = "doctor";
          }

          SharedPreferences prefs = await SharedPreferences.getInstance();
          String userdata = jsonEncode(doc.docs.first.data());
          String userinfo = json.encode(doc.docs.first.data());

          prefs.setString('userdata', userdata);
          prefs.setString('userinfo', userinfo);
        });
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> addcat({
    required String title,
    required Uint8List file,
  }) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    String res = "Some error Occurred";
    try {
      if (file != null) {
        // registering user in auth with email and password

        String pic =
            await StorageMethods().uploadImageToStorage('category', file, true);

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

  Future<String> AddDoctor({
    required String email,
    required String password,
    required String name,
    required Uint8List file,
    required dynamic cic,
  }) async {
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
          patient: [],
          bloodtype: '',
          age: '',
          usertype: 'doctor',
          category: cic,
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
}
