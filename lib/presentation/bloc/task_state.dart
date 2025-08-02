import '../../data/models/task_model.dart';

abstract class TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;
  final String filter; // "All", "Active", "Completed"

  TaskLoaded({required this.tasks, this.filter = "All"});
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
