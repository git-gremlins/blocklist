import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;

  const TaskCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (_, __, ___) => SubTask(taskID: 900),
        //     transitionDuration: Duration(milliseconds: 500),
        //     transitionsBuilder: (_, a, __, c) => ScaleTransition(
        //       scale: CurvedAnimation(
        //         parent: a,
        //         curve: Curves.linearToEaseOut,
        //       ),
        //       //100, 0 right to left
        //       alignment: Alignment(100, 0),
        //       child: c,
        //     ),
        //   ),
        // );
      },
      child: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            title,
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
