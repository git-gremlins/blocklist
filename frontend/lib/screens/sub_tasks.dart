import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'package:frontend/types/task/delete_task.dart';
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
            Navigator.pop(context);
          },
          child: Container(
            color: colourChoice(widget.task["endRow"], widget.task["startRow"],
                    widget.task["endCol"], widget.task["startCol"])
                .withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: AutoSizeText(
                          widget.task["name"],
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          maxFontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: AutoSizeText(
                          widget.task["description"],
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          maxFontSize: 12,
                        ),
                      ),
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
        floatingActionButton: IconButton(
          onPressed: () async {
            Navigator.pop(context);
            await deleteTask(RemoveTask(taskId: widget.task["taskId"]));
          },
          icon: const Icon(Icons.delete_forever),
          tooltip: "Delete this task",
        ));
  }
}
