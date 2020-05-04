import 'package:expenditurely/model/stream_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expenditurely/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:expenditurely/model/task_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenditurely/model/stream_data.dart';

FirebaseUser loggedUser;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  int setValue;
  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedUser = user;
        print(loggedUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setValue = 0;
    getCurrentUser();
  }

  String newTask;
  int amount;
  int choice;
  String dateDay;
  setSelectRadio(int val) {
    setState(() {
      setValue = val;
    });
  }

  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), topLeft: Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Transaction',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  color: kSecThemeColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              value: 1,
              groupValue: setValue,
              title: Text(
                'Income',
                style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
              ),
              activeColor: kSecThemeColor,
              onChanged: (val) {
                setState(() {
                  choice = val;
                });

                print(val);
                setSelectRadio(val);
              },
            ),
            RadioListTile(
              value: 2,
              groupValue: setValue,
              title: Text(
                'Expenses',
                style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
              ),
              activeColor: kSecThemeColor,
              onChanged: (val) {
                setState(() {
                  choice = val;
                });

                print(val);
                setSelectRadio(val);
              },
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                boxShadow: [kShadow],
              ),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Montserrat'),
                decoration: InputDecoration.collapsed(
                    hintText: 'Enter Amount in Rupees',
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat', color: Colors.black38)),
                autofocus: true,
                onChanged: (value) {
                  amount = int.parse(value);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                boxShadow: [kShadow],
              ),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Montserrat'),
                decoration: InputDecoration.collapsed(
                    hintText: 'Add Description',
                    hintStyle: TextStyle(
                        fontFamily: 'Montserrat', color: Colors.black38)),
                onChanged: (value) {
                  newTask = value;
                },
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 0, right: 0),
                    padding: EdgeInsets.all(12.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                      boxShadow: [kShadow],
                    ),
                    child: Text(
                        _dateTime == null
                            ? 'Pick a Date'
                            : DateFormat("MMMM dd, y").format(_dateTime),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                    boxShadow: [kShadow],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2050))
                          .then((date) {
                        setState(() {
                          _dateTime = date;
                          dateDay = DateFormat("MMMM dd, y").format(_dateTime);
                        });
                      });
                    },
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                print(newTask);
                print(amount);
                print(choice);
                _fireStore.collection('${loggedUser.email}').add({
                  'newTask': newTask,
                  'amount': amount,
                  'choice': choice,
                  'dateDay': dateDay
                });
                Provider.of<TaskData>(context)
                    .addTask(newTask, amount, choice, dateDay);
                StreamData();
                Navigator.pop(context);
              },
              color: kMainThemeColor,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'ADD',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
