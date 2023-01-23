import 'dart:ffi';

import 'package:chatapp/screens/AllDoctor.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/roundedbtn.dart';
import 'package:chatapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:typed_data';
import 'package:chatapp/resources/add_methods.dart';
import 'package:motion_toast/motion_toast.dart';
import '../responsive/navigation_drawer.dart';
import 'package:chatapp/models/scedule.dart';

class AddDoctor extends StatefulWidget {
  static const String id = 'AddDoctor';

  final desc;
  const AddDoctor({Key? key, required this.desc});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool _isLoading = false;
  late String email;
  late String password;
  late String name;
  late String bloodtype;
  late String age;
  late String bio;
  late String gender;
  late int phonenumber;

  final _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  Uint8List? _image;

  void adddoc(context) async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AddMethods().AddDoctor(
        email: email,
        password: password,
        name: name,
        cic: widget.desc['category'],
        file: _image!,
        dule: widget.desc['scedule'],
        phonenumber: phonenumber,
        age: age,
        gender: gender);

    // if string returned is sucess, user has been created
    if (res == "success") {
      Navigator.pushNamed(context, AllDoctor.id);

      MotionToast.success(
        title: Text('Success'),
        description: Text('Doctor successfully Add'),
      );

      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Add Doctor'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Flexible(
                  //   child: Hero(
                  //     tag: 'logo',
                  //     child: Container(
                  //       height: 200.0,
                  //       child: Image.asset('images/logo.png'),
                  //     ),
                  //   ),
                  // ),

                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                                backgroundColor: Colors.red,
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://i.stack.imgur.com/l60Hf.png'),
                                backgroundColor: Colors.red,
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      name = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter you name'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter you email'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    controller: TextEditingController(
                        text: widget.desc['category']['title'].toString()),
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter you age'),
                  ),

                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      age = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter you age'),
                  ),

                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      gender = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter you gender'),
                  ),

                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      //Do something with the user input.
                      phonenumber = int.parse(value);
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter you phonenumber'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter you password'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      // print(email);
                      // print(password);
                      try {
                        // final newUser = await _auth.createUserWithEmailAndPassword(
                        //     email: email, password: password);
                        // _firestore.collection('Users').add({
                        //   'name': name,
                        //   'email': email,
                        //   'age': age,
                        //   'bloodtype': bloodtype
                        // });

                        adddoc(context);
                        // if (newUser != null) {
                        //   Navigator.pushNamed(context, ChatScreen.id);
                        // }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    title: 'Add Doctor',
                    colour: Colors.blueAccent,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
