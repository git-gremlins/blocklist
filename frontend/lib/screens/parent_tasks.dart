import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/TaskGrid.dart';

class ParentTaskScreen extends StatefulWidget {
  const ParentTaskScreen({super.key});

  @override
  State<ParentTaskScreen> createState() => _ParentTaskScreenState();
}

class _ParentTaskScreenState extends State<ParentTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: TaskGrid())),
    );
  }
}
