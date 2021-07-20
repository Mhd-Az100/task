import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/model/user.dart';
import 'package:task/screen/sign%20in.dart';

import '../utility.dart';
import 'constent.dart';

class MyDrawer extends StatelessWidget {
  User? user = new User();
  bool isSign = false;
  String? image;
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
  }

  @override
  Widget build(BuildContext context) {
    //

    getpref();
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
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: isSign
                  ? Text(
                      user!.firstname! + " " + user!.lastname! + " ",
                      style: kTextBody,
                    )
                  : Text(''),
              accountEmail: isSign
                  ? Text(
                      user!.email!,
                      style: kTextinfo,
                    )
                  : Text(''),
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
                        user!.phone!,
                        style: kTitledrawer,
                      ),
                      leading: Icon(Icons.phone)),
                  InkWell(
                    onTap: () {
                      print('ppppppppppppppppppp $user!.picture');

                      removpref();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
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
        ),
      ),
    );
  }
}
