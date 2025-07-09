import 'package:dailywellness_app/models/task.dart';

class TaskUtils {
  static int getCompletedTasksCount(List<Task> tasks) {
    return tasks.where((task) => task.isCompleted).length;
  }

  static String formatTaskCount(int count) {
    if (count == 0) return 'No tasks completed';
    if (count == 1) return '1 task completed';
    return '$count tasks completed';
  }

  static bool isValidTaskName(String name) {
    return name.trim().isNotEmpty && name.trim().length >= 2;
  }
}
