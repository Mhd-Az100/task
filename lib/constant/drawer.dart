import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/screen/sign%20in.dart';
import '../utility.dart';
import 'constent.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? id;
  String? firstname;
  String? lastname;
  String? picture;
  String? email;
  String? phone;
  bool isSign = false;
  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    firstname = preferences.getString('firstname');
    lastname = preferences.getString('lastname');
    email = preferences.getString('email');
    picture = preferences.getString('picture');
    phone = preferences.getString('phone');

    if (firstname != null) {
      setState(() {
        id = preferences.getString('id');
        firstname = preferences.getString('firstname');
        lastname = preferences.getString('lastname');
        email = preferences.getString('email');
        picture = preferences.getString('picture');
        phone = preferences.getString('phone');
        isSign = true;
      });
    }
  }

  removpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('firstname');
    preferences.remove('lastname');
    preferences.remove('email');
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Signin(),
    ));
  }

  @override
  void initState() {
    super.initState();
    getpref();
    print('ppppppppppppppppppp $picture');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
      child: Scaffold(
        backgroundColor: kchooseColor,
        body: Container(
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
                        firstname! + " " + lastname! + " ",
                        style: kTextBody,
                      )
                    : Text(''),
                accountEmail: isSign
                    ? Text(
                        email!,
                        style: kTextinfo,
                      )
                    : Text(''),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    radius: 40,
                    child: Utility.imageFromBase64String(picture!),
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
                          phone!,
                          style: kTitledrawer,
                        ),
                        leading: Icon(Icons.phone)),
                    InkWell(
                      onTap: () {
                        print('ppppppppppppppppppp $picture');

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
      ),
    );
  }
}
