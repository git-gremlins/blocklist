import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/FutureData.dart';
import 'package:frontend/widgets/TaskCard.dart';
import 'package:frontend/widgets/TaskSpannableGridCells.dart';

import 'package:spannable_grid/spannable_grid.dart';

class SubTaskGrid extends StatefulWidget {
  dynamic parentTask;
  SubTaskGrid({super.key, required this.parentTask});

  @override
  State<SubTaskGrid> createState() => _SubTaskGrid();
}

class _SubTaskGrid extends State<SubTaskGrid> {
  List<SpannableGridCellData> taskCells = <SpannableGridCellData>[];

  @override
  Widget build(BuildContext context) {
    final taskStream = supabase.from("Task").stream(primaryKey: ["taskId"]).eq(
        "parentTaskId", widget.parentTask["taskId"]);
    return StreamBuilder(
      stream: taskStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Map<String, dynamic>> tasks = snapshot.data!;
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
                task: task,
              ),
            ),
          );
        }
        return TaskSpannableGridCells(
          taskCells: taskCells,
          tasks: tasks,
          parentTask: widget.parentTask,
        );
      },
    );
  }
}
