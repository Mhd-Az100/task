import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/constant/constent.dart';
import 'package:task/database/database_helper.dart';
import 'package:task/model/user.dart';
import 'package:task/screen/home.dart';
import 'package:task/screen/sign%20in.dart';
import 'package:task/widget/widget.dart';

import '../utility.dart';

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
  SharedPreferences? preferences;
  final signupformKey = new GlobalKey<FormState>();
  User user = User();
  String? _birthdayVar;
  String _dropDownValue = 'Male';
  bool ispass = true;
  int? id;
  String? firstname;
  String? lastname;
  String? phone;
  String? picture;
  String? email;

  //------------------shared preferences----------------------------------------
  savepref(
    String? firstName,
    String? lastName,
    String? email,
    int? id,
    String? picture,
    String? phone,
  ) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString('firstname', firstName!);
    preferences!.setString('lastname', lastName!);
    preferences!.setString('email', email!);
    preferences!.setString('id', id!.toString());
    preferences!.setString('picture', picture.toString());
    preferences!.setString('phone', phone.toString());
  }
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
                                    validator: (val) => val!.length == 0
                                        ? 'Please Enter Your First Name'
                                        : null),
                                textfaild(
                                    size: size / 2.5,
                                    onSaved: (val) =>
                                        setState(() => user.lastname = val),
                                    controller: lastNameController,
                                    txttype: TextInputType.name,
                                    heant: 'Last Name',
                                    icon: Icons.person_pin,
                                    validator: (val) => val!.length == 0
                                        ? 'Please Enter Your Last Name'
                                        : null),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                textfaild(
                                    size: size / 2.5,
                                    onTap: () => _addBirthday(),
                                    onSaved: (val) => setState(
                                        () => user.dataofbirth = _birthdayVar),
                                    readOnly: true,
                                    controller: databirthController,
                                    txttype: TextInputType.datetime,
                                    heant: 'DateBirth',
                                    icon: Icons.date_range,
                                    validator: (val) => val!.length == 0
                                        ? 'Please Enter Your Birth'
                                        : null),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    width: size.width / 2.5,
                                    // padding:
                                    //     EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5)
                                        ]),
                                    child: Center(
                                      child: DropdownButton<String>(
                                        value: _dropDownValue,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Color(0xFF4DA7AA),
                                            fontSize: 20),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.white,
                                        ),
                                        onChanged: (newValue) {
                                          _addGender(newValue);
                                        },
                                        items: <String>['Male', 'Female']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          textfaild(
                            size: size,
                            controller: phoneController,
                            validator: validateMobile,
                            onSaved: (val) => setState(() => user.phone = val),
                            txttype: TextInputType.number,
                            heant: 'Phone',
                            icon: Icons.phone,
                          ),
                          textfaild(
                            size: size,
                            controller: emailController,
                            txttype: TextInputType.emailAddress,
                            heant: 'email',
                            onSaved: (val) => setState(() => user.email = val),
                            icon: Icons.email,
                            validator: validateEmail,
                          ),
                          textfaild(
                              size: size,
                              controller: passwordController,
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
                          //------------------------------button Sign Up----------------

                          RawMaterialButton(
                            onPressed: () {
                              if (_file != null) {
                                signupInsert();
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'choose picture please',
                                    backgroundColor: Color(0xC7E64141),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM);
                              }
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
                              padding: EdgeInsets.fromLTRB(20, 7, 20, 5),
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

  String? validateMobile(String? value) {
    if (value!.length == 0)
      return 'Please enter PhoneNumber';
    else
      return null;
  }

  String? validateEmail(String? value) {
    if (value!.length == 0)
      return 'Please enter your Email';
    else if (!EmailValidator.validate(value))
      return 'Please enter a valid Email';
    else
      return null;
  }

  _addGender(var value) {
    setState(() {
      _dropDownValue = value;
    });
    _dropDownValue = value;
  }

  _addBirthday() async {
    DateTime? temp = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select a date',
    );
    _birthdayVar = "${temp!.day}/${temp.month}/${temp.year}";
    if (_birthdayVar == null) return;
    databirthController.text = _birthdayVar!;
  }

  getuserid() async {
    Database? db = await DatabaseHelper.instance.database;
    List<Map> x = await db!
        .rawQuery("SELECT * FROM User WHERE id=(SELECT MAX(id) FROM User)");
    for (var item in x) {
      id = item['id'];
      print('===================$id');
    }
    savepref(user.firstname, user.lastname, user.email, id, user.picture,
        user.phone);
    return id;
  }

  signupInsert() {
    if (signupformKey.currentState!.validate()) {
      getuserid();
      user.id = id;
      user.firstname = firstNameController.text.toString();
      user.lastname = lastNameController.text.toString();
      user.email = emailController.text.toString();
      user.phone = phoneController.text.toString();
      user.password = passwordController.text.toString();
      user.gender = genderController.text.toString();
      user.dataofbirth = databirthController.text.toString();
      if (_file != null) {
        user.picture = Utility.base64String(_file!.readAsBytesSync());
      }

      DatabaseHelper.instance.insertUser(user).then((value) {
        // savepref(user.firstname, user.lastname, user.email, user.id,
        //     user.picture, user.phone);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()),
        );
      }).catchError((error) {
        print('feild insert ${error.toString()}');
      });
    }
  }
}
