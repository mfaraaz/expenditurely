import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'task.dart';

class TaskData extends ChangeNotifier {
  List<Task> tasks = [
//    Task(
//        taskText: 'Dominos',
//        amount: 2000,
//        taskType: 2,
//        dateDay: 'April 22,2020'),
//    Task(taskText: 'Bank', amount: 5000, taskType: 1, dateDay: 'April 13,202')
  ];

//
//  UnmodifiableListView<Task> get tasks {
//    return UnmodifiableListView(tasks);
//  }

  void addTask(String taskData, int amount, int choice, String dateDay) {
    final task = Task(
        taskText: taskData, amount: amount, taskType: choice, dateDay: dateDay);
//    tasks.add(task);
    tasks.insert(0, task);
    print(task.taskText);
    print(task.amount);
    print(task.taskType);
    notifyListeners();
  }

  Task deleteData(Task task) {
    Task task1 = task;
    tasks.remove(task);
    notifyListeners();
    return task1;
  }
}
