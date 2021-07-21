import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/model/user.dart';
import 'package:task/screen/sign%20in.dart';
import '../utility.dart';
import 'constent.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  User? user = new User();
  bool isSign = false;
  String? image;

  @override
  void initState() {
    super.initState();
    getpref();
  }

  @override
  Widget build(BuildContext context) {
    removpref() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove('User');

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Signin(),
      ));
    }

    Size size = MediaQuery.of(context).size;

    return Drawer(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0), bottomRight: Radius.circular(200)),
        ),
        child: image != null
            ? ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      user!.firstname! + " " + user!.lastname! + " ",
                      style: kTextBody,
                    ),
                    accountEmail: Text(
                      user!.email!,
                      style: kTextinfo,
                    ),
                    currentAccountPicture: GestureDetector(
                      child: CircleAvatar(
                        radius: 40,
                        child: Utility.imageFromBase64String(image!),
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF93CFC0),
                          Color(0xFF9FBFC4),
                          Color(0xFFBFDEE7),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                            title: Text(
                              user!.gender!,
                              style: kTitledrawer,
                            ),
                            leading: Icon(Icons.person_outline)),
                        ListTile(
                            title: Text(
                              user!.phone!,
                              style: kTitledrawer,
                            ),
                            leading: Icon(Icons.phone)),
                        ListTile(
                            title: Text(
                              user!.address!,
                              style: kTitledrawer,
                            ),
                            leading: Icon(Icons.place)),
                        InkWell(
                          onTap: () {
                            removpref();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => Signin(),
                            ));
                          },
                          child: ListTile(
                              title: Text(
                                'Sign Out',
                                style: kTitledrawer,
                              ),
                              leading: Icon(Icons.logout)),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: Container(
                  child: Text('loding...'),
                ),
              ),
      ),
    );
  }

  getpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> userMap = {};
    final String? userStr = prefs.getString('User');
    if (userStr != null) {
      userMap = jsonDecode(userStr);
    }

    if (userMap.isNotEmpty) {
      user = User.fromJson(userMap);
    }

    image = prefs.getString("IMG-KEY $user.id.toString()");
    setState(() {});
  }
}
