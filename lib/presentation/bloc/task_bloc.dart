import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskLoading()) {
    // Load tasks initially
    on<LoadTasks>((event, emit) {
      final tasks = repository.getAllTasks();
      _sortTasksByDate(tasks);
      emit(TaskLoaded(tasks: tasks));
    });

    // Add task
    on<AddTask>((event, emit) async {
      await repository.addTask(event.task);
      final tasks = repository.getAllTasks();
      _sortTasksByDate(tasks);
      emit(TaskLoaded(tasks: tasks));
    });

    // Update task
    on<UpdateTask>((event, emit) async {
      await repository.updateTask(event.task);
      final tasks = repository.getAllTasks();
      _sortTasksByDate(tasks);
      emit(TaskLoaded(tasks: tasks));
    });

    // Delete task
    on<DeleteTask>((event, emit) async {
      await repository.deleteTask(event.id);
      final tasks = repository.getAllTasks();
      _sortTasksByDate(tasks);
      emit(TaskLoaded(tasks: tasks));
    });

    // Toggle completion
    on<ToggleTaskCompletion>((event, emit) async {
      await repository.toggleTaskCompletion(event.id);
      final tasks = repository.getAllTasks();
      _sortTasksByDate(tasks);
      emit(TaskLoaded(tasks: tasks));
    });

    // Filter tasks
    on<FilterTasks>((event, emit) {
      final allTasks = repository.getAllTasks();
      List<TaskModel> filtered = [];

      if (event.filter == 'Active') {
        filtered = allTasks.where((t) => !t.isCompleted).toList();
      } else if (event.filter == 'Completed') {
        filtered = allTasks.where((t) => t.isCompleted).toList();
      } else {
        filtered = allTasks;
      }

      _sortTasksByDate(filtered);
      emit(TaskLoaded(tasks: filtered, filter: event.filter));
    });
  }

  // Helper method to sort tasks by due date (nulls last)
  void _sortTasksByDate(List<TaskModel> tasks) {
    tasks.sort((a, b) {
      if (a.dueDate == null) return 1;
      if (b.dueDate == null) return -1;
      return a.dueDate!.compareTo(b.dueDate!);
    });
  }
}
