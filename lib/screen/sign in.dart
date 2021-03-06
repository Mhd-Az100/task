import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/constant/constent.dart';
import 'package:task/database/database_helper.dart';
import 'package:task/model/user.dart';
import 'package:task/screen/sign%20up.dart';
import 'package:task/widget/widget.dart';

import 'home.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

enum LoginStatus { notSignIn, signIn }

class _SigninState extends State<Signin> {
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  final loginformKey = new GlobalKey<FormState>();
  bool ispass = true;
  User user = new User();
  SharedPreferences? preferences;
  int? id;

  @override
  void initState() {
    super.initState();
    // getPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Sign in',
            style: kTextTitleStyle,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF4DA7AA),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF4DA7AA),
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(200),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(children: [
                      Form(
                        key: loginformKey,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "   E_mail:",
                                  style: TextStyle(
                                    color: klabelColor,
                                    fontFamily: "Raleway",
                                    fontSize: 20,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10.0)),
                                textfaild(
                                  size: size,
                                  controller: loginEmailController,
                                  txttype: TextInputType.emailAddress,
                                  heant: 'email',
                                  icon: Icons.email,
                                  validator: validateEmail,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  "   password:",
                                  style: TextStyle(
                                    color: klabelColor,
                                    fontFamily: "Raleway",
                                    fontSize: 20,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10.0)),
                                textfaild(
                                    size: size,
                                    controller: loginPasswordController,
                                    onSaved: (val) =>
                                        setState(() => user.password = val),
                                    txttype: TextInputType.visiblePassword,
                                    heant: 'Password',
                                    icon: Icons.lock,
                                    ispassword: ispass,
                                    suffixIcon: ispass
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    suffixPressed: () {
                                      setState(() {
                                        ispass = !ispass;
                                      });
                                    },
                                    validator: (val) => val!.length == 0
                                        ? 'Please Enter Your Password'
                                        : null),
                                Padding(padding: EdgeInsets.all(3.0)),
                                Align(
                                  alignment: Alignment.center,
                                ),
                                Padding(padding: EdgeInsets.only(top: 10.0)),
                                Center(
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        user.email = loginEmailController.text;
                                        user.password =
                                            loginPasswordController.text;
                                      });
                                      signin();
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Container(
                                      height: 40,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          gradient: kButtongradientColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          )),
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 5),
                                      child: Text(
                                        'Sign in',
                                        textAlign: TextAlign.center,
                                        style: kTextButton,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 2.0)),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => Signup(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.grey.withOpacity(0.3),
                                          )
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        'You Don`t Have an Account ? Sign_Up',
                                        style:
                                            TextStyle(color: klabelTextColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  //------------------shared preferences----------------------------------------
  savepref(User user) async {
    preferences = await SharedPreferences.getInstance();
    bool truee = await preferences!.setString("User", jsonEncode(user));
    print(truee);
  }

  String? validateEmail(String? value) {
    if (value!.length == 0)
      return 'Please enter your Email';
    else if (!EmailValidator.validate(value))
      return 'Please enter a valid Email';
    else
      return null;
  }

//==========================sign in==================
  signin() async {
    if (loginformKey.currentState!.validate()) {
      loginformKey.currentState!.save();
      // getuserid();
      // Future<User?> getlog(String email, String password) {
      //   var res = DatabaseHelper.instance.getLogin(user.email!, user.password!);
      //   return res;
      // }
      var res =
          await DatabaseHelper.instance.getLogin(user.email!, user.password!);
      if (res == 0) {
        Fluttertoast.showToast(
            backgroundColor: Color(0xC5E22222),
            msg: 'error',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      } else {
        user = res;
        savepref(user);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => Home(res.id.toString()),
          ),
        );
      }
    }
  }
}
