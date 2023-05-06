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
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return SubTaskScreen(task: task);
            },
            transitionsBuilder: (context, animation1, animation2, child) {
              return ScaleTransition(
                scale: animation1,
                child: child,
              );
            },
            transitionDuration: Duration(seconds: 3),
            reverseTransitionDuration: Duration(seconds: 3),
          ),
        );
        // MaterialPageRoute(
        //   builder: (context) => SubTaskScreen(
        //     task: task,
        //   ),
        // ));
      },
      child: Hero(
        tag: "task-${task["taskId"]}",
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
      ),
    );
  }
}
