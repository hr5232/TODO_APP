import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/task_model.dart';
import '../../presentation/bloc/task_bloc.dart';
import '../../presentation/bloc/task_event.dart';
import '../../presentation/bloc/task_state.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My TODOs'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              context.read<TaskBloc>().add(FilterTasks(value));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All')),
              const PopupMenuItem(value: 'Active', child: Text('Active')),
              const PopupMenuItem(value: 'Completed', child: Text('Completed')),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            final tasks = state.tasks;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.priority),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) {
                      context
                          .read<TaskBloc>()
                          .add(ToggleTaskCompletion(task.id));
                    },
                  ),
                  onLongPress: () {
                    context.read<TaskBloc>().add(DeleteTask(task.id));
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
