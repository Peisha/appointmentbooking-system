import 'package:chatapp/resources/add_methods.dart';
import 'package:chatapp/resources/auth_methods.dart';
import 'package:chatapp/screens/Admin_Screen.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/roundedbtn.dart';
import 'package:chatapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

class AddLabTest extends StatefulWidget {
  static const String id = 'Add_labeTests_screen';
  final emails;

  AddLabTest({Key? key, this.emails});

  @override
  State<AddLabTest> createState() => _AddLabTestState();
}

class _AddLabTestState extends State<AddLabTest> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool _isLoading = false;

  late String title;
  late String email;

  final _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  Uint8List? _image;
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  void initState() {
    super.initState();

    _getData();
  }

  _getData() async {
    email = widget.emails;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add labtest'),
        centerTitle: true,

        
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
                Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? Container(
                              height: 400,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: MemoryImage(_image!),
                                      fit: BoxFit.cover)),
                            )
                          : Container(
                              height: 400,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScdLfSSFXaNry6gnT4YGoTYq0TPftXcJJIbE1B6H7fJQwQr1bR'),
                                      fit: BoxFit.cover)),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 0,
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
                    title = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter you title'),
                ),
                SizedBox(
                  height: 10.0,
                ),

                TextField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                  controller: TextEditingController(text: widget.emails ?? ''),
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter you email'),
                ),

                SizedBox(
                  height: 8.0,
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
                      String res = await AddMethods()
                          .AddReport(name: title, file: _image!, email: email);
                      MotionToast.success(
                        description: Text('Report Added Success'),
                      );
                      Navigator.pop(context);

                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  title: 'Add labtest',
                  colour: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
