import 'package:flutter/material.dart';
import 'package:frontend/screens/fetch_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ParentTaskScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late dynamic _tasks;
//
//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }
//
//   void _getData() async {
//     _tasks = await getParentTasks();
//     Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: _tasks == null || _tasks!.isEmpty
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: _tasks!.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: const EdgeInsets.all(15),
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(width: 0.2, color: Colors.grey)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(_tasks![index]["name"].toString()),
//                       Text(_tasks![index]["description"].toString()),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late dynamic _task;
//
//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }
//
//   void _getData() async {
//     _task = await getTaskTree(10);
//     Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<dynamic> childTasks = _task["childTasks"];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_task["name"]),
//       ),
//       body: _task == null || _task!.isEmpty
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: childTasks.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: const EdgeInsets.all(15),
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(width: 0.2, color: Colors.grey)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(childTasks[index]["name"]),
//                       Text(childTasks[index]["description"]),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
