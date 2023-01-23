import 'dart:convert';

import 'package:chatapp/components/schedule_card.dart';
import 'package:chatapp/constants.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/resources/add_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:motion_toast/motion_toast.dart';

class DetailScreen extends StatefulWidget {
  var _name;
  var _description;
  var _imageUrl;
  final allinfo;

  DetailScreen(this._name, this._description, this._imageUrl, this.allinfo);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Color> lstcolor = [kBlueColor, kYellowColor, kOrangeColor];
  List<dynamic>? filterlst1;
  List<dynamic>? fillst;
  List<DateTime>? times;

  String? selecteddate;
  String? nowdate;
  DateTime? bookdate;

  String? timtim;
  RxString selectedtime = 'jpt'.obs;
  RxInt activeindex = 0.obs;
  var currentuser;
  var userinfo;
  String? email;
  bool status = false;

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = (prefs.getString('userdata') ?? '');
    var datas = (prefs.getString('userinfo') ?? '');

    currentuser = User.fromJson(jsonDecode(data.toString()));

    email = widget.allinfo['email'];
    userinfo = json.decode(datas.toString());
  }

  @override
  void initState() {
    _loadCounter();
    _getData();
    super.initState();
  }

  _loadCounter() async {
    List<dynamic> filterlst = json.decode(widget.allinfo['scedule']);
    final day = DateFormat.E().format(DateTime.now());
    nowdate = day;
    int indexw = filterlst.indexWhere((element) => element['weekday'] == day);
    var cutList = filterlst.getRange(indexw, filterlst.length).toList();
    filterlst.removeRange(indexw, filterlst.length);
    filterlst = cutList + filterlst;
    // filterlst.addAll(cutList);

    filterlst1 = filterlst;

    DateTime today = DateTime.now();
    DateTime sevenDaysFromToday = today.add(const Duration(days: 7));

    timtim = DateFormat.MMM().format(sevenDaysFromToday);

    times = [
      DateTime.now(),
      today.add(const Duration(days: 1)),
      today.add(const Duration(days: 2)),
      today.add(const Duration(days: 3)),
      today.add(const Duration(days: 4)),
      today.add(const Duration(days: 5)),
      today.add(const Duration(days: 6)),
    ];

    var cutlsttime = times!.getRange(indexw, times!.length).toList();
    // times!.removeRange(indexw, times!.length);
    // times = cutlsttime + times!;

    fillst = filterlst.where((element) => element['time'].length > 1).toList();
  }

  String todayMonth(DateTime today) {
    return DateFormat.MMM().format(today);
  }

  String monthenumber(DateTime today) {
    return DateFormat('d').format(today);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.network(
                      widget._imageUrl,
                      height: 120,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget._name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kTitleTextColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget._description,
                          style: TextStyle(
                            color: kTitleTextColor.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: kBlueColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/phone.svg',
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: kYellowColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/chat.svg',
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: kOrangeColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/video.svg',
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kTitleTextColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.allinfo['name'] +
                      ' is the top most ' +
                      widget.allinfo['category']['title'] +
                      '  heart surgeon in Flower\nHospital. She has done over 100 successful sugeries\nwithin past 3 years. She has achieved several\nawards for her wonderful contribution in her own\nfield. She’s available for private consultation for\ngiven schedules.',
                  style: TextStyle(
                    height: 1.6,
                    color: kTitleTextColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Upcoming Schedules',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kTitleTextColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListView.separated(
                          itemCount: filterlst1!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            // List<dynamic> lst = json
                            //     .decode(widget.allinfo['scedule'])
                            //     .where((element) => element.time.length > 0)
                            //     .toList();
                            bool weeks = filterlst1![index]['time'].length > 0;
                            // final day = DateFormat.E().format(DateTime.now());
                            // int indexw =
                            //     lst.indexWhere((element) => element['weekday'] == day);

                            // var cutList = lst.getRange(indexw, lst.length).toList();
                            // lst.removeRange(indexw, lst.length);
                            // lst.addAll(cutList);

                            // List<dynamic> lst0 = lst
                            //     .where((element) => element.time.length > 0)
                            //     .toList();

                            return Visibility(
                                visible: weeks ? true : false,
                                child: GestureDetector(
                                    onTap: () {
                                      activeindex.value = index;
                                      selecteddate =
                                          filterlst1![index]['weekday'];
                                      selectedtime.value = 'jpt';
                                      bookdate = times![index];
                                    },
                                    child: Card(
                                      child: Obx(() => Container(
                                            color: activeindex.value == index
                                                ? Colors.black
                                                : const Color.fromARGB(
                                                    255, 72, 107, 123),
                                            width: 100,
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    todayMonth(times![index]),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    monthenumber(times![index]),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    filterlst1![index]
                                                        ['weekday'],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    )));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // PageView.builder(
                //   scrollDirection: Axis.horizontal,
                //   itemCount: filterlst1!.length,
                //   itemBuilder: (context, index0) {
                //     return ListView.separated(
                //       shrinkWrap: true,
                //       physics: NeverScrollableScrollPhysics(),
                //       separatorBuilder: (context, index) => const Divider(),
                //       itemCount: filterlst1![index0]['time'].length,
                //       itemBuilder: (context, index) {
                //         return Text(filterlst1![index0]['time'][index]);
                //       },
                //     );
                //   },
                // )

                SizedBox(
                  height: 30,
                ),

                Text(
                  'Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kTitleTextColor,
                  ),
                ),

                Expanded(
                  child: Obx(
                    () => GridView.builder(
                      itemCount: filterlst1![activeindex.value]['time'].length,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2,
                              crossAxisSpacing: 2.0,
                              mainAxisSpacing: 1.0),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            selectedtime.value =
                                filterlst1![activeindex.value]['time'][index];
                            setState(() {});
                          },
                          child: Obx(
                            () => Card(
                              color: selectedtime.value ==
                                      filterlst1![activeindex.value]['time']
                                          [index]
                                  ? Colors.black
                                  : const Color.fromARGB(255, 16, 82, 136),
                              child: Center(
                                child: Obx(
                                  () => Text(
                                    filterlst1![activeindex.value]['time']
                                        [index],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                ElevatedButton(
                    onPressed: () async {
                      if (selectedtime.value != 'jpt' && email!.isNotEmpty) {
                        String res = await AddMethods().BookAppointment(
                            doctor: widget.allinfo['email'],
                            title: widget.allinfo['name'],
                            bookdate: times![activeindex.value],
                            status: status,
                            time: selectedtime.value,
                            category: widget.allinfo['category'],
                            patient: currentuser!.name,
                            patientemail: currentuser!.email,
                            docpic: widget.allinfo['pic'],
                            patientpic: currentuser!.pic);

                        if (res == 'success') {
                          MotionToast.success(
                                  description: Text('appointment booked'))
                              .show(context);
                        }
                      } else {
                        MotionToast.warning(
                                description: Text('error Invalid credential'))
                            .show(context);
                      }
                    },
                    child: Text('Book'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
