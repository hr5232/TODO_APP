import 'package:hive/hive.dart';
import '../../data/models/task_model.dart';

class TaskRepository {
  final Box<TaskModel> taskBox;

  TaskRepository(this.taskBox);

  Future<void> addTask(TaskModel task) async {
    await taskBox.put(task.id, task);
  }

  List<TaskModel> getAllTasks() {
    return taskBox.values.toList();
  }

  Future<void> updateTask(TaskModel task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    await taskBox.delete(id);
  }

  Future<void> toggleTaskCompletion(String id) async {
    final task = taskBox.get(id);
    if (task != null) {
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      await taskBox.put(id, updatedTask);
    }
  }
}
