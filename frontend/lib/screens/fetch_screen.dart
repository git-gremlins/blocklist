import 'package:flutter/material.dart';
import 'package:frontend/api.dart';

class ParentTaskScreen extends StatefulWidget {
  const ParentTaskScreen({super.key, required this.title});

  final String title;

  @override
  State<ParentTaskScreen> createState() => _ParentTaskScreenState();
}

class _ParentTaskScreenState extends State<ParentTaskScreen> {
  final Future<dynamic> _task = Future<dynamic>.delayed(
    const Duration(seconds: 0),
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
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Result: ${snapshot.data["name"]}'),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
