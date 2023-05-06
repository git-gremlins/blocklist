import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/FutureData.dart';
import 'package:frontend/widgets/TaskCard.dart';
import 'package:frontend/widgets/TaskSpannableGridCells.dart';

import 'package:spannable_grid/spannable_grid.dart';

class TaskGrid extends StatefulWidget {
  const TaskGrid({super.key});

  @override
  State<TaskGrid> createState() => _TaskGrid();
}

class _TaskGrid extends State<TaskGrid> {
  List<SpannableGridCellData> taskCells = <SpannableGridCellData>[];

  @override
  Widget build(BuildContext context) {
    final parentTasksStream = supabase.from("Task").stream(
        primaryKey: ["taskId"]).eq("userId", supabase.auth.currentUser!.id);
    return StreamBuilder(
      stream: parentTasksStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        Iterable<Map<String, dynamic>> tasks =
            snapshot.data!.where((task) => task["parentTaskId"] == null);
        print(tasks);
        taskCells = [];
        for (var task in tasks) {
          taskCells.add(
            SpannableGridCellData(
              id: task["taskId"],
              column: task["startCol"] + 1,
              row: task["startRow"] + 1,
              columnSpan: (task["endCol"] - task["startCol"]) + 1,
              rowSpan: (task["endRow"] - task["startRow"]) + 1,
              child: TaskCard(
                key: Key("${task["taskId"]}"),
                title: task["name"],
              ),
            ),
          );
        }
        return TaskSpannableGridCells(taskCells: taskCells, tasks: tasks);
      },
    );
  }
}
