import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:task/screen/sign%20up.dart';
import 'package:task/widget/widget.dart';

import '../constent.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  final loginformKey = new GlobalKey<FormState>();

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
                                    val: 'Please Enter Your email'),
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
                                    txttype: TextInputType.emailAddress,
                                    heant: 'email',
                                    icon: Icons.email,
                                    val: 'Please Enter Your email'),
                                Padding(padding: EdgeInsets.all(3.0)),
                                Align(
                                  alignment: Alignment.center,
                                  // child: TextButton(
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       state = true;
                                  //       Fluttertoast.showToast(
                                  //           msg: 'Send Email Again',
                                  //           toastLength: Toast.LENGTH_SHORT,
                                  //           gravity: ToastGravity.BOTTOM);
                                  //     });
                                  //   },
                                  //   child: Container(
                                  //     padding: EdgeInsets.all(10),
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(5),
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //           blurRadius: 5,
                                  //           color: Colors.grey.withOpacity(0.3),
                                  //         )
                                  //       ],
                                  //       color: Colors.white,
                                  //     ),
                                  //     child: Text(
                                  //       'Not received any Code ?',
                                  //       style:
                                  //           TextStyle(color: Colors.grey[850]),
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10.0)),
                                // Center(
                                //   child: ReusableRaisedButton(
                                //     onpressed: () {
                                //       // if (loginformKey.currentState
                                //       //     .validate()) {
                                //       //   setState(() {
                                //       //     Map sendcode = {
                                //       //       "e_mail": loginEmailController.text,
                                //       //       "Code": loginCodeController.text,
                                //       //     };
                                //       //     senddata(context, sendcode);
                                //       //     print('sendcode $sendcode');
                                //       //   });
                                //       // }
                                //     },
                                //     text: 'LogIn',
                                //     color: kButtongradientColor,
                                //   ),
                                // ),
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

  String? validateMobile(String value) {
    if (value.length == 0)
      return 'Please enter PhoneNumber';
    else if (value.length != 9)
      return 'Mobile Number Must be like (+963-9********)';
    else
      return null;
  }

  String? validateEmail(String value) {
    if (value.length == 0)
      return 'Please enter your Email';
    else if (!EmailValidator.validate(value))
      return 'Please enter a valid Email';
    else
      return null;
  }
}
