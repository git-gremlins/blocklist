import 'package:flutter/material.dart';
import 'package:frontend/widgets/TaskCard.dart';
import 'package:frontend/widgets/TaskSpannableGridCells.dart';

import 'package:spannable_grid/spannable_grid.dart';

class TaskGrid extends StatefulWidget {
  final Stream taskStream;
  final Iterable<Map<String, dynamic>> Function(dynamic data)?
      filterDataCallback;
  final Map<String, dynamic>? parentTask;
  const TaskGrid(
      {super.key,
      required this.taskStream,
      this.filterDataCallback,
      this.parentTask});

  @override
  State<TaskGrid> createState() => _TaskGrid();
}

class _TaskGrid extends State<TaskGrid> {
  List<SpannableGridCellData> taskCells = <SpannableGridCellData>[];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.taskStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        Iterable<Map<String, dynamic>> tasks = widget.filterDataCallback == null
            ? snapshot.data
            : widget.filterDataCallback!(snapshot.data);
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
