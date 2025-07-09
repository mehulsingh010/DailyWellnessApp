import 'package:dailywellness_app/utils/task_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dailywellness_app/models/task.dart';

void main() {
  group('TaskUtils', () {
    test('getCompletedTasksCount returns correct count', () {
      final tasks = [
        Task(id: '1', name: 'A', createdAt: DateTime.now(), isCompleted: true),
        Task(id: '2', name: 'B', createdAt: DateTime.now(), isCompleted: false),
        Task(id: '3', name: 'C', createdAt: DateTime.now(), isCompleted: true),
      ];
      expect(TaskUtils.getCompletedTasksCount(tasks), 2);
    });

    test('formatTaskCount returns correct string', () {
      expect(TaskUtils.formatTaskCount(0), 'No tasks completed');
      expect(TaskUtils.formatTaskCount(1), '1 task completed');
      expect(TaskUtils.formatTaskCount(3), '3 tasks completed');
    });

    test('isValidTaskName validates names', () {
      expect(TaskUtils.isValidTaskName(''), false);
      expect(TaskUtils.isValidTaskName('A'), false);
      expect(TaskUtils.isValidTaskName('Go'), true);
    });
  });
}
