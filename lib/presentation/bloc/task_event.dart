import '../../data/models/task_model.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final TaskModel task;
  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final TaskModel task;
  UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final String id;
  DeleteTask(this.id);
}

class ToggleTaskCompletion extends TaskEvent {
  final String id;
  ToggleTaskCompletion(this.id);
}

class FilterTasks extends TaskEvent {
  final String filter; // "All", "Active", "Completed"
  FilterTasks(this.filter);
}
