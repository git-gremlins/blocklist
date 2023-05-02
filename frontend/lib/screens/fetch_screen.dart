import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/widgets/FutureData.dart';

class TaskViewScreen extends StatefulWidget {
  const TaskViewScreen({super.key, required this.title});

  final String title;

  @override
  State<TaskViewScreen> createState() => _TaskViewScreenState();
}

class _TaskViewScreenState extends State<TaskViewScreen> {
  final Future<dynamic> _task = Future.delayed(
    const Duration(seconds: 2),
    () => getTaskTree(10),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureData<String, dynamic>(
          future: _task,
          onDataCallback: (snapshot) {
            return "hello";
          },
          onErrorCallback: (error) {
            return "Error: $error";
          },
          loadingValue: "Loading...",
          onReturnCallback: (result) {
            return Text(result);
          },
        ),
      ),
      body: FutureData<Widget, dynamic>(
          future: _task,
          loadingValue: const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
          onDataCallback: (data) {
            dynamic childTasks = data["childTasks"];
            return TaskChildList(data: childTasks);
          },
          onErrorCallback: (error) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: $error'),
            );
          },
          onReturnCallback: (result) {
            return result;
          }),
    );
  }
}

class TaskChildList extends StatelessWidget {
  final dynamic data;

  const TaskChildList({required this.data, super.key});

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
