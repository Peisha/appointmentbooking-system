import 'package:chatapp/screens/AddDoctor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:collection';
import 'package:chatapp/models/scedule.dart';

class AddScedule extends StatefulWidget {
  static const String id = 'AddScedule';
  final category;
  const AddScedule({Key? key, required this.category});

  @override
  State<AddScedule> createState() => _AddSceduleState();
}

class _AddSceduleState extends State<AddScedule> {
  List<String> day = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
  RxString active = 'Sun'.obs;

  List<String> time01 = [
    '5AM - 7AM',
    '7AM - 9PM',
    '9AM - 11AM',
  ];

  List<String> time02 = [
    '11AM - 1PM',
    '1PM - 3PM',
    '3PM - 5PM',
  ];

  List<Color> allcolor = [
    Color.fromARGB(255, 147, 197, 238),
    Color.fromARGB(255, 243, 114, 114),
    Color.fromARGB(255, 243, 174, 114),
    Color.fromARGB(255, 138, 243, 114),
    Color.fromARGB(255, 114, 243, 228),
    Color.fromARGB(255, 243, 114, 189),
    Color.fromARGB(255, 140, 114, 243),
  ];

  final sliderContoller = PageController(initialPage: 0);
  final timeContoller = PageController(initialPage: 0);

  List<String> mon = [];
  RxInt activeindex = 0.obs;

  RxList<Scedule> sun = [
    Scedule(weekday: 'Sun', time: []),
    Scedule(weekday: 'Mon', time: []),
    Scedule(weekday: 'Tue', time: []),
    Scedule(weekday: 'Wed', time: []),
    Scedule(weekday: 'Thur', time: []),
    Scedule(weekday: 'Fri', time: []),
    Scedule(weekday: 'Sat', time: []),
  ].obs;

  List<dynamic> sat = [
    Scedule(weekday: 'Sun', time: []),
    Scedule(weekday: 'Mon', time: []),
    Scedule(weekday: 'Tue', time: []),
    Scedule(weekday: 'Wed', time: []),
    Scedule(weekday: 'Thur', time: []),
    Scedule(weekday: 'Fri', time: []),
    Scedule(weekday: 'Sat', time: []),
  ];
  String weekday = '';
  List<String> time = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Set sechdule'),
          centerTitle: true,
          actions: [
            Row(
              children: [
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddDoctor.id, arguments: {
                        'category': widget.category,
                        'scedule': sat,
                      });
                    },
                    child: const Text(
                      'Next',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      onPrimary: Colors.white,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Select Weeks',
                style: TextStyle(
                    color: Color.fromARGB(255, 88, 163, 225),
                    fontSize: 29,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 90,
                child: PageView(
                  controller: sliderContoller,
                  children: [
                    ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(left: 5),
                              width: 90,
                              height: 70,
                              child: GestureDetector(
                                  onTap: () {
                                    active.value = day[index];
                                    activeindex.value = index;
                                    setState(() {});
                                  },
                                  child: Obx(
                                    () => Container(
                                      color: active.value == day[index]
                                          ? Colors.grey[400]
                                          : allcolor[index],
                                      child: Card(
                                          color: active.value == day[index]
                                              ? allcolor[index]
                                              : Colors.white,
                                          child: Center(
                                            child: Text(
                                              day[index],
                                              style: TextStyle(
                                                  color:
                                                      active.value == day[index]
                                                          ? Colors.white
                                                          : allcolor[index],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            ),
                                          )),
                                    ),
                                  )));
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: day.length)
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Select time',
                style: TextStyle(
                    color: Color.fromARGB(255, 88, 163, 225),
                    fontSize: 29,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Container(
                    height: 70,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (sun[activeindex.value]
                                    .time
                                    .contains(time01[index])) {
                                  sun[activeindex.value]
                                      .time
                                      .remove(time01[index]);
                                  sat[activeindex.value]
                                      .time
                                      .remove(time01[index]);
                                } else {
                                  sun[activeindex.value]
                                      .time
                                      .add(time01[index]);
                                  sat[activeindex.value]
                                      .time
                                      .add(time01[index]);
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 50,
                                width: 120,
                                child: Obx(
                                  () => Card(
                                    color: sun[activeindex.value]
                                            .time
                                            .contains(time01[index])
                                        ? Colors.black
                                        : allcolor[3 + index],
                                    child: Center(
                                      child: Text(
                                        time01[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: 3),
                  ),
                  Container(
                    height: 70,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (sun[activeindex.value]
                                    .time
                                    .contains(time02[index])) {
                                  sun[activeindex.value]
                                      .time
                                      .remove(time02[index]);
                                  sat[activeindex.value]
                                      .time
                                      .remove(time02[index]);
                                } else {
                                  sun[activeindex.value]
                                      .time
                                      .add(time02[index]);
                                  sat[activeindex.value]
                                      .time
                                      .add(time02[index]);
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 50,
                                width: 120,
                                child: Obx(() => Card(
                                    color: sun[activeindex.value]
                                            .time
                                            .contains(time02[index])
                                        ? Colors.black
                                        : allcolor[index],
                                    child: Center(
                                        child: Text(
                                      time02[index],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )))),
                              ));
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: 3),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
