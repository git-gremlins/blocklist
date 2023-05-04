import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/FutureData.dart';
import 'package:frontend/widgets/PopUpForm.dart';
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
        title: const Text(
            'Stupid fucking flutter I will spit in the face of god when this works'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PopUpForm();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
