import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/resources/auth_methods.dart';
import 'package:chatapp/responsive/doctor_drawer.dart';
import 'package:chatapp/responsive/navigation_drawer.dart';
import 'package:chatapp/responsive/patient_drawer.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/roundedbtn.dart';
import 'package:chatapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motion_toast/motion_toast.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 55,
                  ),
                  const Text(
                    'Login Now',
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  Container(
                    height: 300.0,
                    width: 300.0,
                    child: Image.asset(
                      'assets/images/doctors.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email'),
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
                        hintText: 'Enter your password'),
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                    child: const Text(
                      'Dont have account Sigup Now',
                      style: TextStyle(color: Colors.blueAccent),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  RoundedButton(
                    title: 'Log In',
                    colour: Colors.lightBlueAccent,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        String res = await AuthMethods()
                            .loginUser(email: email, password: password);
                        if (res == 'admin') {
                          Navigator.pushNamed(context, DrawerNavigation.id);
                        }
                        if (res == 'patient') {
                          Navigator.pushNamed(context, PatientNavigation.id);
                        }
                        if (res == 'doctor') {
                          Navigator.pushNamed(context, DoctorNavigation.id);
                        }
                        MotionToast.success(
                          description: Text('login Success'),
                        );
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
