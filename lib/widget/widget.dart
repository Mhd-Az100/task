import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constent.dart';

Widget textfaild(
    {Size? size,
    TextEditingController? controller,
    String? val,
    String? heant,
    IconData? icon,
    FormFieldSetter<String>? onSaved,
    TextInputType? txttype}) {
  return Container(
    width: (size!.width),
    height: 50,
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
    child: TextFormField(
      controller: controller,
      onSaved: onSaved,
      keyboardType: txttype,
      validator: (val) => val!.length == 0 ? val : null,
      decoration: InputDecoration(
        border: InputBorder.none,
        icon: Icon(
          icon,
          color: klabelTextColor.withOpacity(0.5),
        ),
        hintText: heant,
        hintStyle: TextStyle(
          color: klabelTextColor.withOpacity(0.5),
        ),
      ),
    ),
  );
}

Widget pickImg(Size size, Future<dynamic> getImage(dynamic x), File? _file) {
  return Container(
    width: size.width,
    // height: 300,
    decoration: BoxDecoration(
      color: Color(0xFF4DA7AA),
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(50),
        bottomLeft: Radius.circular(50),
      ),
    ),
    child: GestureDetector(
      onTap: () => getImage(ImageSource.gallery),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFDADADA),
          shape: BoxShape.circle,
        ),
        width: 120,
        height: 120,
        margin: EdgeInsets.only(top: 30, bottom: 10),
        child: _file == null
            ? Icon(Icons.add_a_photo)
            : Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: FileImage(
                        _file,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
      ),
    ),
  );
}
