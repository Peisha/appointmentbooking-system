import 'dart:ffi';

import 'package:chatapp/screens/Donations.dart';
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

class AddDonation extends StatefulWidget {
  static const String id = 'AddDonations';

  const AddDonation({
    Key? key,
  });

  @override
  State<AddDonation> createState() => _AddDonationState();
}

class _AddDonationState extends State<AddDonation> {
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
    String res = await AddMethods().AddDonation(
        email: email,
        name: name,
        file: _image!,
        phonenumber: phonenumber,
        gender: gender,
        bloodtype: bloodtype,
        age: age);

    // if string returned is sucess, user has been created
    if (res == "success") {
      Navigator.pushNamed(context, Donation.id);
      MotionToast.success(
        description: Text('Donation Added Success'),
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
          title: Text('Add Donation '),
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
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      bloodtype = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your bloodtype'),
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
                    onChanged: (value) {
                      gender = value;
                      //Do something with the user input.
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Enter Gender'),
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

                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      phonenumber = int.parse(value);
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter you phonenumber'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),

                  RoundedButton(
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });

                      try {
                        adddoc(context);

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    title: 'Add Donation',
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
