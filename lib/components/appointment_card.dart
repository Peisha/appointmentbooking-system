import 'dart:convert';

import 'package:chatapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentCard extends StatefulWidget {
  final doctor;
  const AppointmentCard({Key? key, required this.doctor});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  var currentuser;
  var userinfo;
  String? email;
  bool isLoading = true;
  RxBool status = false.obs;

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = (prefs.getString('userdata') ?? '');
    var datas = (prefs.getString('userinfo') ?? '');

    currentuser = User.fromJson(jsonDecode(data.toString()));

    userinfo = json.decode(datas.toString());

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Text('...loading');
    }
    return Container(
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 3),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                widget.doctor?['docpic'] ?? '',
                height: 70,
                width: 70,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ' + 'Dr ' + widget.doctor?['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Category: ' + widget.doctor?['category']?['title'],
                  ),
                  Text(DateFormat('MM/dd/yyyy')
                      .format(widget.doctor['bookdate'].toDate()))
                ],
              ),
              Visibility(
                visible: currentuser.usertype == 'doctor' ? true : false,
                child: Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: widget.doctor['status'] || status.value
                            ? Colors.green
                            : Colors.blue),
                    onPressed: () {
                      status.value = !status.value;
                    },
                    child: Text(widget.doctor['status'] || status.value
                        ? 'verified'
                        : 'pending'))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
