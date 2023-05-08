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
        color: colourChoice(
            task["endRow"], task["startRow"], task["endCol"], task["startCol"]),
        child: Center(
          child: AutoSizeText(
            task["name"],
            style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Colors.black),
            minFontSize: 12,
          ),
        ),
      ),
    );
  }
}
