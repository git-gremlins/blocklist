import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/types/task/task.dart';

class ParentTaskScreen extends StatefulWidget {
  const ParentTaskScreen({super.key, required this.title});

  final String title;

  @override
  State<ParentTaskScreen> createState() => _ParentTaskScreenState();
}

class _ParentTaskScreenState extends State<ParentTaskScreen> {
  final Future<dynamic> _task = Future.delayed(
    const Duration(seconds: 2),
    () => getTaskTree(10),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<dynamic>(
          future: _task,
          builder: (context, snapshot) {
            String title;
            if (snapshot.hasData) {
              title = snapshot.data["name"];
            } else {
              title = "loading...";
            }
            return Text(title);
          },
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: _task,
        builder: (context, snapshot) {
          dynamic tasklist;
          if (snapshot.hasData) {
            dynamic childTasks = snapshot.data["childTasks"];
            tasklist = TaskChildList(snapshot: snapshot, data: childTasks);
          } else if (snapshot.hasError) {
            tasklist = <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            tasklist = const SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            );
          }
          return tasklist;
        },
      ),
    );
  }
}

class TaskChildList extends StatelessWidget {
  const TaskChildList({required this.data, required this.snapshot, super.key});

  final dynamic data;
  final AsyncSnapshot<dynamic> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.2, color: Colors.grey)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text(data[index]["name"])]),
        );
      },
    );
  }
}
