import 'package:flutter/material.dart';

const kMainThemeColor = Color(0xff724CF9);

const kSecThemeColor = Color(0xff564592);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password.',
  hintStyle: TextStyle(color: Colors.black38),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
);

const kExpDeco = BoxDecoration(
    borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
    color: Color(0xff724CF9),
    boxShadow: [kShadow]);

const kLoginMontsStyle = TextStyle(
  fontSize: 30,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kShadow = BoxShadow(
  blurRadius: 5.0,
  offset: const Offset(3.0, 0.0),
  color: Colors.grey,
);

const kDescText1 = TextStyle(
    color: kSecThemeColor,
    fontFamily: 'Montserrat',
    fontSize: 34,
    fontWeight: FontWeight.bold);

const kDescText2 = TextStyle(
    color: kSecThemeColor,
    fontFamily: 'Montserrat',
    fontSize: 13,
    fontWeight: FontWeight.bold);

const kRegisterButton = BoxDecoration(
  color: Color(0xff724CF9),
  borderRadius: BorderRadius.all(Radius.circular(12)),
  boxShadow: [kShadow],
);
