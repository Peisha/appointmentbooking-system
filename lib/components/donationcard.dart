import 'package:chatapp/models/doctor.dart';
import 'package:chatapp/utils/custom_icons_icons.dart';
import 'package:chatapp/utils/he_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class DonationCard extends StatefulWidget {
  final doctor;

  const DonationCard({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  State<DonationCard> createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  /// **********************************************
  /// LIFE CYCLE METHODS
  /// **********************************************
  ///
  RxBool isExpanded = false.obs;
  RxBool ishidden = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            color: HexColor('#404B63').withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageSection(),
          SizedBox(
            width: 16,
          ),
          _detailsSection(),
        ],
      ),
    );
  }

  /// **********************************************
  /// WIDGETS
  /// **********************************************

  /// Image Section
  Container _imageSection() {
    return Container(
      height: 97,
      width: 90,
      decoration: BoxDecoration(
        color: HexColor('#00C6AD'),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: NetworkImage(widget.doctor['pic'])),
      ),
    );
  }

  /// Details Section
  Column _detailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Age :",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.doctor['age'],
              style: TextStyle(
                color: HexColor('#929BB0'),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Text(
              "Email: ",
              style: TextStyle(
                color: Color.fromARGB(255, 30, 30, 30),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.doctor['email'],
              style: TextStyle(
                color: HexColor('#929BB0'),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "Name: ",
              style: TextStyle(
                color: Color.fromARGB(255, 75, 74, 74),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.doctor['name'],
              style: TextStyle(
                color: Color.fromARGB(255, 91, 95, 97),
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Text(
              "Gender: ",
              style: TextStyle(
                color: Color.fromARGB(255, 75, 74, 74),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.doctor['gender'],
              style: TextStyle(
                color: HexColor('#929BB0'),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "BloodType: ",
              style: TextStyle(
                color: Color.fromARGB(255, 75, 74, 74),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.doctor['bloodtype'],
              style: TextStyle(
                color: HexColor('#929BB0'),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "PhoneNumber: ",
              style: TextStyle(
                color: Color.fromARGB(255, 75, 74, 74),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.doctor['phonenumber'].toString(),
              style: TextStyle(
                color: HexColor('#929BB0'),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
