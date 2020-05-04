import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenditurely/model/task_data.dart';

class AmountData extends StatelessWidget {
  AmountData({this.choice});
  final int choice;
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      int incAmount = 0;
      int expAmount = 0;
      int total = 0;
      for (var i = 0; i < taskData.tasks.length; i++) {
        if (taskData.tasks[i].taskType == 1)
          incAmount += taskData.tasks[i].amount;
        else {
          expAmount += taskData.tasks[i].amount;
        }
      }
      total = incAmount - expAmount;
      if (choice == 1) {
        return Text(
          incAmount != null ? '₹ ${incAmount.toString()}' : '0',
          style: TextStyle(
              color: Color(0xff2F1E6D),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 15),
        );
      } else if (choice == 2) {
        return Text(
          expAmount != null ? '₹ ${expAmount.toString()}' : '0',
          style: TextStyle(
              color: Color(0xff2F1E6D),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 15),
        );
      } else {
        return Text(
          total != null ? '₹ ${total.toString()}' : '0',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        );
      }
      return null;
    });
  }
}
