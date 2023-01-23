import 'package:chatapp/components/FullScreenImage.dart';
import 'package:chatapp/screens/AddLabTest.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:chatapp/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/user.dart' as Users;

class Profile_Screen extends StatefulWidget {
  static const String id = 'profile_screen';

  const Profile_Screen({Key? key}) : super(key: key);

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final ImagePicker _picker = ImagePicker();

  Uint8List? _image;
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  var userData = {};
  int postLen = 0;
  int patient = 0;
  int followers = 0;
  bool ispatient = false;
  bool isLoading = false;
  String usertype = '';
  String pic = '';

  @override
  void initState() {
    super.initState();
    getData();
    _getData();
  }

  var currentuser;
  var userinfo;

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = (prefs.getString('userdata') ?? '');
    var datas = (prefs.getString('userinfo') ?? '');

    currentuser = Users.User.fromJson(jsonDecode(data.toString()));

    userinfo = json.decode(datas.toString());
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // get post lENGTH
      // var postSnap = await FirebaseFirestore.instance
      //     .collection('posts')
      //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      //     .get();

      // postLen = postSnap.docs.length;
      userData = userSnap.data()!;

      patient = userSnap.data()!['patient'].length;
      usertype = userSnap.data()!['usertype'];
      pic = userSnap.data()!['pic'];

      followers = userSnap.data()!['followers'].length;
      ispatient = userSnap
          .data()!['patient']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Text('...loading');
    }
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AddLabTest.id,
                              arguments: currentuser.email);
                        },
                        icon: Icon(
                          Icons.add_box_outlined,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            LoginScreen.id,
                          );
                        },
                        icon: Icon(Icons.logout)),
                  ],
                ),
                Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                              backgroundColor: Colors.red,
                            )
                          : CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(currentuser.pic),
                              backgroundColor: Colors.white,
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    currentuser.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {/* Do something */},
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.emoji_people),
                            Text(currentuser.age,
                                style: TextStyle(fontSize: 22)),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {/* Do something */},
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.bloodtype,
                              color: Colors.red,
                            ),
                            Text(
                              currentuser.bloodtype ?? 'A+',
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {/* Do something */},
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.type_specimen,
                              color: Colors.blue,
                            ),
                            Text(currentuser.gender ?? 'Female',
                                style: TextStyle(fontSize: 22)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'About',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Text(
                //   currentuser.bio,
                //   style: TextStyle(color: Colors.black54),
                // ),

                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('report')
                        .where('email', isEqualTo: currentuser.email)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.5,
                                  crossAxisSpacing: 2.0,
                                  mainAxisSpacing: 1.0),
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, index) {
                            final datas = snapshot.data!.docs[index].data();

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImage(
                                      image: datas['pic'],
                                      title: datas['name'],
                                    ),
                                  ),
                                );
                              },
                              child: Column(children: [
                                Text(datas['name']),
                                Expanded(
                                  child: Image.network(
                                    datas['pic'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ]),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
