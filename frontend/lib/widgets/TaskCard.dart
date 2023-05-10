import 'package:flutter/material.dart';
import 'package:frontend/screens/sub_tasks.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:frontend/widgets/Update_task_form.dart';

import '../helpers/colour_choice.dart';

class TaskCard extends StatefulWidget {
  final dynamic task;

  TaskCard({
    super.key,
    required this.task,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  int calculateMaxLines() {
    var maxLines = 2 *
        (widget.task["endCol"] - widget.task["startCol"] + 1) *
        (widget.task["endRow"] - widget.task["startRow"] + 1);
    return maxLines.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubTaskScreen(
                task: widget.task,
              ),
            ));
      },
      onTap: () {
        showDialog(
          context: context,
          builder: ((context) {
            return UpdateTaskForm(task: widget.task);
          }),
        );
      },
      child: Hero(
        tag: widget.task["taskId"],
        child: Container(
          decoration: BoxDecoration(
            color: colourChoice(widget.task["endRow"], widget.task["startRow"],
                widget.task["endCol"], widget.task["startCol"]),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  widget.task["name"],
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    widget.task["description"],
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1000,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
