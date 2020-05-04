import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_data.dart';

FirebaseUser loggedUser;

class StreamData extends StatefulWidget {
  @override
  _StreamDataState createState() => _StreamDataState();
}

class _StreamDataState extends State<StreamData> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
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
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('{$loggedUser.email}').snapshots(),
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
            final taskData = mess.data['taskData'];
            final amount = mess.data['amount'];
            final choice = mess.data['choice'];
            final dateDay = mess.data['dateDay'];
            Provider.of<TaskData>(context)
                .addTask(taskData, amount, choice, dateDay);
          }
        }
        return null;
      },
    );
  }
}
