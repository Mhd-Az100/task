import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/constent.dart';
import 'package:task/database/database_helper.dart';
import 'package:task/model/user.dart';
import 'package:task/screen/sign%20in.dart';
import 'package:task/widget/widget.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Database? database;
  @override
  void initState() {
    super.initState();
    // createDataBase();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController databirthController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final signupformKey = new GlobalKey<FormState>();
  User user = new User();

  //----------------------img from device---------------------------------------

  File? _file;
  final picker = ImagePicker();

  Future getImage(x) async {
    final pickedFile = await picker.pickImage(source: x);

    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Creat account',
            style: kTextTitleStyle,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF4DA7AA),
      ),
      body: Container(
        color: Color(0xFF4DA7AA),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                  Form(
                    key: signupformKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          pickImg(size, getImage, _file),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                textfaild(
                                    size: size / 2.5,
                                    onSaved: (val) =>
                                        setState(() => user.firstname = val),
                                    controller: firstNameController,
                                    txttype: TextInputType.name,
                                    heant: 'Ferst Name',
                                    icon: Icons.person_pin,
                                    val: 'Please Enter Your First Name'),
                                textfaild(
                                    size: size / 2.5,
                                    onSaved: (val) =>
                                        setState(() => user.lastname = val),
                                    controller: lastNameController,
                                    txttype: TextInputType.name,
                                    heant: 'Last Name',
                                    icon: Icons.person_pin,
                                    val: 'Please Enter Your Last Name'),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                textfaild(
                                    size: size / 2.5,
                                    onSaved: (val) =>
                                        setState(() => user.dataofbirth = val),
                                    controller: databirthController,
                                    txttype: TextInputType.datetime,
                                    heant: 'DateBirth',
                                    icon: Icons.date_range,
                                    val: 'Please Enter Your DataBirth'),
                                textfaild(
                                    size: size / 2.5,
                                    onSaved: (val) =>
                                        setState(() => user.gender = val),
                                    controller: databirthController,
                                    txttype: TextInputType.datetime,
                                    heant: 'Gender',
                                    icon: Icons.date_range,
                                    val: 'Please Enter Your DataBirth'),
                              ],
                            ),
                          ),

                          textfaild(
                              size: size,
                              controller: phoneController,
                              onSaved: (val) =>
                                  setState(() => user.phone = val),
                              txttype: TextInputType.number,
                              heant: 'Phone',
                              icon: Icons.phone,
                              val: 'Please Enter Your phone'),
                          textfaild(
                              size: size,
                              controller: emailController,
                              txttype: TextInputType.emailAddress,
                              heant: 'email',
                              onSaved: (val) =>
                                  setState(() => user.email = val),
                              icon: Icons.email,
                              val: 'Please Enter Your email'),
                          textfaild(
                              size: size,
                              controller: passwordController,
                              onSaved: (val) =>
                                  setState(() => user.password = val),
                              txttype: TextInputType.visiblePassword,
                              heant: 'Password',
                              icon: Icons.date_range,
                              val: 'Please Enter Your Password'),
                          //------------------------------button Sign Up----------------

                          RawMaterialButton(
                            onPressed: () {
                              user.firstname = firstNameController.toString();
                              user.lastname = lastNameController.toString();
                              user.email = emailController.toString();
                              user.phone = phoneController.toString();
                              user.password = passwordController.toString();
                              user.gender = genderController.toString();
                              user.dataofbirth = databirthController.toString();
                              DatabaseHelper.instance.insertUser(user);
                            },
                            padding: EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                  gradient: kButtongradientColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  )),
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: kTextButton,
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Signin(),
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
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
                                'You have an Account ? Sign_IN',
                                style: TextStyle(color: klabelTextColor),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void createDataBase() async {
  //   database = await openDatabase('task1.db', version: 1,
  //       onCreate: (database, version) async {
  //     print('data base created');
  //     await database
  //         .execute(
  //             'CREATE TABLE Task (id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, email TEXT,phone INTEGER,gender TEXT ,dataofbirth TEXT ,picture TEXT,password TEXT,address TEXT)')
  //         .then((value) {
  //       print('table created');
  //     }).catchError((error) {
  //       print('Error When Created Table ${error.toString()}');
  //     });
  //   }, onOpen: (database) {
  //     print('data base opened');
  //   });
  // }

  // Future insertToDataBase({
  //   @required String? firstname,
  //   String? lastname,
  //   String? email,
  //   int? phone,
  //   String? gender,
  //   String? databirth,
  //   String? picture,
  //   String? password,
  //   String? address,
  // }) async {
  //   return await database!.transaction((txn) async {
  //     await txn
  //         .rawInsert(
  //             'INSERT INTO Task(firstname,lastname,email,phone,gender,dataofbirth,picture ,password,address )VALUES("mohamad","az","mohamadalazmeh4@gmail.com","0931480357","male","2001","x","12345","damas")')
  //         .then((value) {
  //       print('$value insert succes');
  //     }).catchError((error) {
  //       print('insert error ${error.toString()}');
  //     });
  //   });
  // }

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
