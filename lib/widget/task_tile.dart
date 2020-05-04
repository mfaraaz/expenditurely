import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile({this.textTask, this.amount, this.taskType, this.longPressCallBack,this.dayDate});
  final int taskType;
  final String textTask;
  final int amount;
  final String dayDate;
  final Function longPressCallBack;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallBack,
      title: Text(
        textTask != null ? textTask : 'Sample',
      ),
      trailing: Text(
        taskType == 1 ? '+ $amount' : '- $amount',
        style: TextStyle(
            color: taskType == 1 ? Color(0xff02C39A) : Color(0xffC3023C)),
      ),
      subtitle: Text(
        dayDate
      ),
    );
  }
}
