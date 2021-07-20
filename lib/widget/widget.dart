import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/constant/constent.dart';

Widget textfaild(
    {Size? size,
    TextEditingController? controller,
    bool readOnly = false,
    FormFieldValidator<String>? validator,
    String? heant,
    IconData? icon,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    FormFieldSetter<String>? onSaved,
    IconData? suffixIcon,
    bool ispassword = false,
    VoidCallback? suffixPressed,
    TextInputType? txttype}) {
  return Container(
    width: (size!.width),
    height: 50,
    padding: EdgeInsets.only(left: 5),
    margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
    child: TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly,
      controller: controller,
      onSaved: onSaved,
      keyboardType: txttype,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? IconButton(icon: Icon(suffixIcon), onPressed: suffixPressed)
            : null,
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
      obscureText: ispassword,
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
