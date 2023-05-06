import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'package:frontend/types/task/add_task.dart';
import 'package:spannable_grid/spannable_grid.dart';
import 'dart:math' as math;

class TaskSpannableGridCells extends StatefulWidget {
  final List<SpannableGridCellData> taskCells;
  final Iterable<dynamic> tasks;
  final Map<String, dynamic>? parentTask;
  const TaskSpannableGridCells(
      {super.key,
      required this.taskCells,
      required this.tasks,
      this.parentTask});

  @override
  State<TaskSpannableGridCells> createState() => _TaskSpannableGridCells();
}

class _TaskSpannableGridCells extends State<TaskSpannableGridCells> {
  final GlobalKey _gridWidget = GlobalKey();

  Offset? newItemStart;
  Offset? newItemEnd;

  Size _getSize() {
    return _gridWidget.currentContext!.size!;
  }

  RenderBox getParentRenderObject() {
    return _gridWidget.currentContext?.findRenderObject() as RenderBox;
  }

  @override
  Widget build(BuildContext context) {
    return SpannableGrid(
      key: _gridWidget,
      columns: 4,
      rows: 8,
      cells: widget.taskCells,
      onCellChanged: (cell) {
        print('Cell ${cell?.child} changed');
      },
      showGrid: true,
      emptyCellView: GestureDetector(
        onPanStart: (details) => {
          setState(() {
            newItemStart =
                getParentRenderObject().globalToLocal(details.globalPosition);
          })
        },
        onPanUpdate: (details) => {
          setState(() {
            newItemEnd =
                getParentRenderObject().globalToLocal(details.globalPosition);
          })
        },
        onPanEnd: (details) {
          double tileWidth = _getSize().width / 4;
          double tileHeight = _getSize().height / 8;

          if (newItemEnd != null) {
            var start = [
              (newItemStart!.dy / tileHeight).ceil(),
              (newItemStart!.dx / tileWidth).ceil()
            ];

            var end = [
              (newItemEnd!.dy / tileHeight).ceil(),
              (newItemEnd!.dx / tileWidth).ceil()
            ];

            int startRow = math.max(math.min(start[0], end[0]) - 1, 0);
            int startCol = math.max(math.min(start[1], end[1]) - 1, 0);
            int endRow =
                math.max(math.min(math.max(start[0], end[0]) - 1, 7), 0);
            int endCol =
                math.max(math.min(math.max(start[1], end[1]) - 1, 3), 0);

            if (supabase.auth.currentUser == null) return;
            List<bool> collisions = widget.tasks.map((task) {
              return ((task["startRow"] >= startRow &&
                          task["startRow"] <= endRow) ||
                      (task["endRow"] >= endRow && task["endRow"] <= endRow)) &&
                  ((task["startCol"] >= startCol &&
                          task["startCol"] <= endCol) ||
                      (task["endCol"] >= startCol && task["endCol"] <= endCol));
            }).toList();
            if (collisions.contains(true)) return;
            try {
              Future<dynamic> postedTask = postTask(
                AddTask(
                  name: "test task",
                  description: "Just this for now",
                  userId: supabase.auth.currentUser!.id,
                  parentTaskId: widget.parentTask == null
                      ? null
                      : widget.parentTask!["taskId"],
                  startRow: startRow,
                  startCol: startCol,
                  endRow: endRow,
                  endCol: endCol,
                ),
              );
            } catch (err) {
              throw Exception(err);
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(.5)),
            color: Colors.grey
                .withOpacity(0.1), // add your desired background color here
            borderRadius: BorderRadius.circular(
                10.0), // add your desired border radius here
          ),
        ),
      ),
    );
  }
}
