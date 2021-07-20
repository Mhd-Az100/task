import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/screen/home.dart';
import 'package:task/screen/sign%20in.dart';

import 'model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var email;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  email = preferences.getString('User');

  runApp(email != null ? Homepage() : MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signin(),
    );
  }
}

class Homepage extends StatelessWidget {
  User? user = new User();
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

  }

  @override
  Widget build(BuildContext context) {
    getpref();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(user!.id.toString()),
    );
  }
}
