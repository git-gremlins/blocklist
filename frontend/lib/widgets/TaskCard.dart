import 'package:flutter/material.dart';
import 'package:frontend/screens/sub_tasks.dart';

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
        color: Colors.green,
        child: Center(
          child: Text(
            task["name"],
            style: const TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'Roboto',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}
