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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main tasks'),
        actions: [
          IconButton(
            onPressed: () async {
              await supabase.auth.signOut();
            },
            icon: const Icon(Icons.logout),
            tooltip: "Log Out",
          ),
        ],
      ),
      body: TaskGrid(),
    );
  }
}
