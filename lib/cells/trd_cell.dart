import 'package:chatapp/models/doctor.dart';
import 'package:chatapp/screens/detail_screen.dart';
import 'package:chatapp/utils/custom_icons_icons.dart';
import 'package:chatapp/utils/he_color.dart';
import 'package:flutter/material.dart';

class TrdCell extends StatelessWidget {
  final doctor;

  const TrdCell({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  /// **********************************************
  /// LIFE CYCLE METHODS
  /// **********************************************

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(doctor['name'], 'yelo', doctor['pic'], doctor),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 5),
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
      ),
    );
  }

  /// **********************************************
  /// WIDGETS
  /// **********************************************

  /// Image Section
  Container _imageSection() {
    return Container(
      height: 77,
      width: 90,
      decoration: BoxDecoration(
        color: HexColor('#00C6AD'),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: NetworkImage(doctor['pic'])),
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
              'Age: ' + doctor['age'],
              style: TextStyle(
                color: HexColor('#929BB0'),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 4,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Dr ' + doctor['name'],
          style: TextStyle(
            color: Color.fromARGB(255, 91, 95, 97),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          doctor['category']['title'] + ' Specialist',
          style: TextStyle(
            color: HexColor('#929BB0'),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
