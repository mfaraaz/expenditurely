import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expenditurely/components/expanded_tab.dart';
import 'package:expenditurely/constants.dart';
import 'package:expenditurely/components/user_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String userID;
  String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainThemeColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Expenditurely',
                        style: kLoginMontsStyle,
                      ),
                    ],
                  ),
                  height: 245,
                  width: double.infinity,
                  decoration: kExpDeco,
                ),
                Align(
                  alignment: Alignment(0, -0.08),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    height: 265,
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          new BoxShadow(
                            blurRadius: 5.0,
                            offset: const Offset(3.0, 0.0),
                            color: Colors.grey,
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: 'switch',
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff724CF9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                new BoxShadow(
                                  blurRadius: 5.0,
                                  offset: const Offset(3.0, 0.0),
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                ExpandedTab(
                                  displayText: 'LOGIN',
                                  backColor: Colors.white12,
                                  textColor: Color(0xff2F1E6D),
                                  func: () {
                                    print('Button Pressed');
                                  },
                                ),
                                ExpandedTab(
                                  displayText: 'REGISTER',
                                  backColor: Colors.transparent,
                                  textColor: Colors.white,
                                  func: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Welcome',
                            textAlign: TextAlign.start,
                            style: kDescText1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Login to your Account',
                            textAlign: TextAlign.start,
                            style: kDescText2,
                          ),
                        ),
                        UserTextField(
                          hint: 'User ID',
                          func: (value) {
                            userID = value;
                          },
                        ),
                        UserTextField(
                          obscure: true,
                          hint: 'Password',
                          func: (value) {
                            password = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Hero(
                  tag: 'btn',
                  child: Align(
                    alignment: Alignment(0.7, .45),
                    child: FlatButton(
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final newUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: userID, password: password);

                          if (newUser != null) {
                            Navigator.pushNamed(context, '/dashboard');
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Container(
                        height: 42,
                        width: 120,
                        decoration: kRegisterButton,
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'SIGN IN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
