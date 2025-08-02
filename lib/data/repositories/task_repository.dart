import 'package:hive/hive.dart';
import '../../data/models/task_model.dart';

class TaskRepository {
  final Box<TaskModel> taskBox;

  TaskRepository(this.taskBox);
  Future<void> addTask(TaskModel task) async {
    await taskBox.put(task.id, task);
  }
}
