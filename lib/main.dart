import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/screen/home.dart';
import 'package:task/screen/sign%20in.dart';
import 'package:task/screen/sign%20up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var email;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  email = preferences.getString('email');

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
