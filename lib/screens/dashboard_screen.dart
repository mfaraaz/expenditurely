import 'package:expenditurely/screens/add_data.dart';
import 'package:expenditurely/widget/task_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expenditurely/constants.dart';
import 'package:intl/intl.dart';
import 'add_data.dart';
import 'package:expenditurely/model/task_data.dart';
import 'package:expenditurely/widget/amount_data.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser loggedUser;
final _fireStore = Firestore.instance;

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getMessageStreams() async {
    print('${loggedUser.email}');
    Provider.of<TaskData>(context).tasks = [];
    await for (var snapShots
        in _fireStore.collection('${loggedUser.email}').snapshots()) {
      for (var stream in snapShots.documents) {
        final taskData = stream.data['newTask'];
        final amount = stream.data['amount'];
        final choice = stream.data['choice'];
        final dateDay = stream.data['dateDay'];
        print(taskData);
        Provider.of<TaskData>(context)
            .addTask(taskData, amount, choice, dateDay);
      }
    }
  }

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
  Widget build(BuildContext context) {
    //getMessageStreams();
    print(TaskData().tasks);
    String date = DateFormat("EEEE, MMMM dd, y").format(DateTime.now());
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hi ${loggedUser.email}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        'Welcome,',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: kMainThemeColor,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '→',
                      style: TextStyle(
                        fontSize: 38,
                        color: kMainThemeColor,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffB721FF),
                        Color(0xff724CF9),
                        Color(0xff21D4FD)
                      ],
                      stops: [0.0, 0.5, 1],
                    ),
                    boxShadow: [kShadow]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      date,
                      style: TextStyle(
                        color: Color(0xffE2E2E2),
                        fontFamily: 'Montserrat',
                        fontSize: 8,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    AmountData(
                      choice: 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Total Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  color: Color(0xff02C39A),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Income',
                              style: TextStyle(
                                  color: Color(0xff776AA7),
                                  fontFamily: 'Montserrat',
                                  fontSize: 10),
                            )
                          ],
                        ),
                        AmountData(
                          choice: 1,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  color: Color(0xffC3023C),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Expenses',
                              style: TextStyle(
                                  color: Color(0xff776AA7),
                                  fontFamily: 'Montserrat',
                                  fontSize: 10),
                            )
                          ],
                        ),
                        AmountData(
                          choice: 2,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    GestureDetector(
                      onTap: () {
                        getMessageStreams();
                      },
                      child: Container(
                        child: Icon(Icons.refresh),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: AddData(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: kMainThemeColor,
                            boxShadow: [kShadow]),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Transactions',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: TasksList(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class StrData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('${loggedUser.email}');
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('${loggedUser.email}').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        } else {
          final messages = snapshot.data.documents.reversed;
          for (var mess in messages) {
            final taskData = mess.data['newTask'];
            final amount = mess.data['amount'];
            final choice = mess.data['choice'];
            final dateDay = mess.data['dateDay'];
            Provider.of<TaskData>(context)
                .addTask(taskData, amount, choice, dateDay);
            print(taskData);
          }
        }
        return null;
      },
    );
  }
}
