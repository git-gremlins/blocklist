import 'package:flutter/material.dart';
import 'package:frontend/widgets/SubTaskGrid.dart';

class SubTaskScreen extends StatefulWidget {
  dynamic task;
  SubTaskScreen({super.key, required this.task});

  @override
  State<SubTaskScreen> createState() => _SubTaskScreenState();
}

class _SubTaskScreenState extends State<SubTaskScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.task["taskId"]);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SubTaskGrid(
            parentTask: widget.task,
          ),
        ),
      ),
    );
  }
}
