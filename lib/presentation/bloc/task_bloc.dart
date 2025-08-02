import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskLoading()) {
    on<LoadTasks>((event, emit) {
      final tasks = repository.getAllTasks();
      emit(TaskLoaded(tasks: tasks));
    });

    on<AddTask>((event, emit) async {
      await repository.addTask(event.task);
      final tasks = repository.getAllTasks();
      emit(TaskLoaded(tasks: tasks));
    });

    on<UpdateTask>((event, emit) async {
      await repository.updateTask(event.task);
      final tasks = repository.getAllTasks();
      emit(TaskLoaded(tasks: tasks));
    });

    on<DeleteTask>((event, emit) async {
      await repository.deleteTask(event.id);
      final tasks = repository.getAllTasks();
      emit(TaskLoaded(tasks: tasks));
    });

    on<ToggleTaskCompletion>((event, emit) async {
      await repository.toggleTaskCompletion(event.id);
      final tasks = repository.getAllTasks();
      emit(TaskLoaded(tasks: tasks));
    });

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

      emit(TaskLoaded(tasks: filtered, filter: event.filter));
    });
  }
}
