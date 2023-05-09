import 'package:flutter/material.dart';
import 'package:frontend/screens/sub_tasks.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../helpers/colour_choice.dart';

class TaskCard extends StatelessWidget {
  final dynamic task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubTaskScreen(
                task: task,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colourChoice(task["endRow"], task["startRow"],
                task["endCol"], task["startCol"])),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: AutoSizeText(
                  task["name"],
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  maxFontSize: 22,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: AutoSizeText(
                  task["description"],
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                  maxFontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
