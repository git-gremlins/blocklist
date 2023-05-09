import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/TaskGrid.dart';

class ParentTaskScreen extends StatefulWidget {
  const ParentTaskScreen({super.key});

  @override
  State<ParentTaskScreen> createState() => _ParentTaskScreenState();
}

class _ParentTaskScreenState extends State<ParentTaskScreen> {
  final parentTasksStream = supabase.from("Task").stream(
      primaryKey: ["taskId"]).eq("userId", supabase.auth.currentUser!.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TaskGrid(
            taskStream: parentTasksStream,
            filterDataCallback: (data) =>
                data.where((task) => task["parentTaskId"] == null),
          ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () async {
          await supabase.auth.signOut();
        },
        icon: const Icon(Icons.logout),
        tooltip: "Log Out",
      ),
    );
  }
}
