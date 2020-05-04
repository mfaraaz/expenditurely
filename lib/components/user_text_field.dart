import 'package:flutter/material.dart';
import 'package:expenditurely/constants.dart';

class UserTextField extends StatelessWidget {
  UserTextField({@required this.hint, this.func, this.obscure = false});
  final String hint;
  final Function func;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 30),
      child: TextField(
        style: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),
        keyboardType: TextInputType.emailAddress,
        onChanged: func,
        obscureText: obscure,
        decoration: kTextFieldDecoration.copyWith(
          hintText: hint,
        ),
      ),
    );
  }
}
