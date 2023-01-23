import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentCard0 extends StatefulWidget {
  final doctor;
  const AppointmentCard0({Key? key, required this.doctor});

  @override
  State<AppointmentCard0> createState() => _AppointmentCard0State();
}

class _AppointmentCard0State extends State<AppointmentCard0> {
  RxBool status = false.obs;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              widget.doctor?['patientpic'] ?? '',
              height: 70,
              width: 70,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                  height: 10,
                ),
                Text(
                  widget.doctor?['patient'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.doctor?['category']?['title'] ?? '',
                ),
                Text(DateFormat('MM/dd/yyyy')
                    .format(widget.doctor['bookdate'].toDate()))
              ],
            ),
            Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: widget.doctor['status'] || status.value
                        ? Colors.green
                        : Colors.blue),
                onPressed: () {
                  status.value = !status.value;
                },
                child: Text(widget.doctor['status'] || status.value
                    ? 'verified'
                    : 'pending')))
          ],
        ),
      ),
    );
  }
}
