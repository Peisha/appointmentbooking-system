import 'package:chatapp/constants.dart';
import 'package:chatapp/screens/AddLabTest.dart';
import 'package:chatapp/screens/AddScedule.dart';
import 'package:chatapp/screens/AllAppointment.dart';
import 'package:chatapp/screens/AllCategory.dart';
import 'package:chatapp/screens/AllDoctor.dart';
import 'package:chatapp/screens/AllPatient.dart';
import 'package:chatapp/screens/AllTest.dart';
import 'package:chatapp/screens/Donations.dart';
import 'package:flutter/material.dart';

class Admin_Screen extends StatefulWidget {
  static const String id = 'admin_screen';

  const Admin_Screen({Key? key});

  @override
  State<Admin_Screen> createState() => _Admin_ScreenState();
}

class _Admin_ScreenState extends State<Admin_Screen> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Admin',
                    style: TextStyle(
                        color: Color.fromARGB(255, 251, 253, 255),
                        fontSize: 37,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Dashboard',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 37,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: kBlueColor,
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AllDoctor.id,
                              arguments: 'doctor');
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/doctor1.png',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Doctor",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: kOrangeColor,
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AllPatient.id,
                              arguments: 'patient');
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/patient.jpg',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Patient",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: kYellowColor,
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AllCategory.id);
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/docs.jpg',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Category",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: kTitleTextColor,
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Donation.id);
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.bloodtype,
                                color: Colors.red,
                                size: 42,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Donation",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: kGreenColor,
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AllAppointment.id);
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/appointment.jpg',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Appointment",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: kPurpleColor,
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AllTest.id);
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/scedule.jpg',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Lab Test",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ))),
    );
  }
}
