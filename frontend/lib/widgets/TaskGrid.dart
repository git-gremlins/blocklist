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
  final Future<List<dynamic>> _parentTasks = Future.delayed(
      const Duration(seconds: 1),
      () => getParentTasks(supabase.auth.currentUser!.id));

  List<SpannableGridCellData> taskCells = <SpannableGridCellData>[];

  @override
  Widget build(BuildContext context) {
    return FutureData<Widget, List<dynamic>>(
      future: _parentTasks,
      onDataCallback: (tasks) {
        for (int i = 0; i < tasks.length; i++) {
          taskCells.add(
            SpannableGridCellData(
              id: tasks[i]["taskId"],
              column: tasks[i]["startCol"] + 1,
              row: tasks[i]["startRow"] + 1,
              columnSpan: (tasks[i]["endCol"] - tasks[i]["startCol"]) + 1,
              rowSpan: (tasks[i]["endRow"] - tasks[i]["startRow"]) + 1,
              child: TaskCard(
                title: tasks[i]["name"],
              ),
            ),
          );
        }
        return TaskSpannableGridCells(taskCells: taskCells);
      },
      onReturnCallback: (result) => result,
      onErrorCallback: (error) => TaskSpannableGridCells(taskCells: taskCells),
      loadingValue: TaskSpannableGridCells(taskCells: taskCells),
    );
  }
}
