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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubTaskScreen(
                task: widget.task,
              ),
            ));
      },
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: ((context) {
            return UpdateTaskForm(task: widget.task);
          }),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: colourChoice(widget.task["endRow"], widget.task["startRow"],
              widget.task["endCol"], widget.task["startCol"]),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
