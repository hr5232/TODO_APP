import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/models/task_model.dart'; // Correct file and name

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
      home: Scaffold(
        appBar: AppBar(title: Text('TODO App')),
        body: Center(child: Text('Let\'s build a TODO app!')),
      ),
    );
  }
}
