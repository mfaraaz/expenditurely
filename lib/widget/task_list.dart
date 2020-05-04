import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:expenditurely/model/task_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final task = taskData.tasks[index];
          return TaskTile(
            textTask: task.taskText,
            taskType: task.taskType,
            amount: task.amount,
            longPressCallBack: () {
              taskData.deleteData(task);
            },
            dayDate: task.dateDay,
          );
        },
        itemCount: taskData.tasks.length,
      );
    });
  }
}
