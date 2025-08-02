import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/models/task_model.dart';
import 'data/repositories/task_repository.dart';
import 'presentation/bloc/task_bloc.dart';
import 'presentation/bloc/task_event.dart';
import 'presentation/screens/task_list_screen.dart';
import 'presentation/screens/add_task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasksBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),

      // Define your routes
      routes: {
        '/add': (context) => const AddTaskScreen(),
      },

      // Provide Bloc and set home screen
      home: BlocProvider(
        create: (context) {
          final taskBox = Hive.box<TaskModel>('tasksBox');
          return TaskBloc(TaskRepository(taskBox))..add(LoadTasks());
        },
        child: const TaskListScreen(),
      ),
    );
  }
}
