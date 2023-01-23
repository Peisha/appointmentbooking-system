import 'package:chatapp/constants.dart';
import 'package:chatapp/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LabTestCard extends StatelessWidget {
  final allinfo;

  LabTestCard({Key? key, required this.allinfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: InkWell(
        onTap: () {},
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                allinfo['pic'],
                height: 100,
                width: 100,
              ),
              title: Text(
                allinfo['name'],
                style: TextStyle(
                  color: kTitleTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                DateFormat('MM/dd/yyyy').format(allinfo['bookdate'].toDate()),
                style: TextStyle(
                  color: kTitleTextColor.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
