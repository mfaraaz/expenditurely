import 'package:expenditurely/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class LauncherScreen extends StatefulWidget {
  static const String id = 'launcher_screen';
  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff724CF9),
      body: SafeArea(
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            return Navigator.pushNamed(context, '/login');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Expenditurely',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                child: Image.asset('images/main_logo.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
