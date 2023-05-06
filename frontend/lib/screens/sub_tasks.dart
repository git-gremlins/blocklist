import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/SubTaskGrid.dart';
import 'package:frontend/widgets/TaskGrid.dart';

class SubTaskScreen extends StatefulWidget {
  dynamic task;
  SubTaskScreen({super.key, required this.task});

  @override
  State<SubTaskScreen> createState() => _SubTaskScreenState();
}

class _SubTaskScreenState extends State<SubTaskScreen> {
  Stream _get_stream() {
    return supabase.from("Task").stream(primaryKey: ["taskId"]).eq(
        "parentTaskId", widget.task["taskId"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TaskGrid(
            parentTask: widget.task,
            taskStream: _get_stream(),
          ),
        ),
      ),
    );
  }
}
