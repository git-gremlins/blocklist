import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/TaskGrid.dart';

import '../helpers/colour_choice.dart';

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
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          print('border click: go back');
          Navigator.pop(context);
        },
        child: Container(
          color: colourChoice(widget.task["endRow"], widget.task["startRow"],
                  widget.task["endCol"], widget.task["startCol"])
              .withOpacity(1),
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: SafeArea(
              child: ClipRRect(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TaskGrid(
                          parentTask: widget.task,
                          taskStream: _get_stream(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
