import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
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

  GlobalKey taskGrid = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Hero(
                tag: "task-${widget.task["taskId"]}",
                child: Container(
                  color: Colors.red,
                ),
              ),
            ),
            Center(
              key: taskGrid,
              child: TaskGrid(
                parentTask: widget.task,
                taskStream: _get_stream(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
