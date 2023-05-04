import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'package:frontend/types/task/task.dart';
import 'package:frontend/widgets/FutureData.dart';

class ParentTaskScreen extends StatefulWidget {
  const ParentTaskScreen({super.key});

  @override
  State<ParentTaskScreen> createState() => _ParentTaskScreenState();
}

class _ParentTaskScreenState extends State<ParentTaskScreen> {
  final Future<List<dynamic>> _parentTasks =
      Future.delayed(const Duration(seconds: 1), () => getParentTasks());

  void _logout() {
    print(supabase.auth.currentUser);
    supabase.auth.signOut();
    print(supabase.auth.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        actions: [
          ElevatedButton(onPressed: _logout, child: const Text("Logout"))
        ],
      ),
      body: FutureData<Widget, List<dynamic>>(
        future: _parentTasks,
        onDataCallback: (data) {
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                String taskName = data[index]["name"];
                return TaskCard(
                  taskTitle: Text(taskName),
                );
              });
        },
        onErrorCallback: (error) => Text("Error: $error"),
        onReturnCallback: (result) => result,
        loadingValue: const SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Text taskTitle;

  const TaskCard({super.key, required this.taskTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.2, color: Colors.grey),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [taskTitle]),
    );
  }
}
