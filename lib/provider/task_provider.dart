import 'package:dailywellness_app/models/task.dart';
import 'package:dailywellness_app/utils/task_utils.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(id: '1', name: 'Drink water', createdAt: DateTime.now()),
    Task(id: '2', name: 'Meditate', createdAt: DateTime.now()),
    Task(id: '3', name: 'Walk', createdAt: DateTime.now()),
  ];

  List<Task> get tasks => _tasks;

  int get completedTasksCount => TaskUtils.getCompletedTasksCount(_tasks);

  void addTask(String name, String notes) {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      notes: notes,
      createdAt: DateTime.now(),
    );
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTask(String taskId) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      notifyListeners();
    }
  }

  void removeTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}
