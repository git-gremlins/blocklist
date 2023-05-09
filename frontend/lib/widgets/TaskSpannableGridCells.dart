import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'package:frontend/types/task/add_task.dart';
import 'package:frontend/types/task/update_task.dart';
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
  bool dragging = false;
  late double tileWidth;
  late double tileHeight;

  Size _getSize() {
    return _gridWidget.currentContext!.size!;
  }

  RenderBox getParentRenderObject() {
    return _gridWidget.currentContext?.findRenderObject() as RenderBox;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tileWidth = _getSize().width / 4;
      tileHeight = _getSize().height / 8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SpannableGrid(
          key: _gridWidget,
          columns: 4,
          rows: 8,
          cells: widget.taskCells,
          onCellChanged: (cell) {
            // where the hell does this ID come from haha how on earth does it corresponds with the task ID
            int? taskId = cell?.id as int;
            updateTask(
              UpdateTask(
                taskId: taskId,
                startRow: cell!.row - 1,
                startCol: cell.column - 1,
                endRow: cell.row - 1 + cell.rowSpan - 1,
                endCol: cell.column - 1 + cell.columnSpan - 1,
              ),
            );
          },
          showGrid: true,
          emptyCellView: GestureDetector(
            onPanStart: (details) {
              Offset position =
                  getParentRenderObject().globalToLocal(details.globalPosition);
              setState(() {
                newItemStart = Offset(
                  (position.dx / tileWidth).ceil().toDouble(),
                  (position.dy / tileWidth).ceil().toDouble(),
                );
                dragging = true;
                newItemEnd = Offset.zero;
              });
            },
            onPanUpdate: (details) {
              Offset position =
                  getParentRenderObject().globalToLocal(details.globalPosition);
              setState(() {
                newItemEnd = Offset(
                  (position.dx / tileWidth).ceil().toDouble(),
                  (position.dy / tileWidth).ceil().toDouble(),
                );
              });
            },
            onPanEnd: (details) {
              setState(() {
                dragging = false;
              });

              print([newItemStart, newItemEnd]);

              if (newItemEnd != null) {
                var start = [
                  newItemStart!.dy.toInt(),
                  newItemStart!.dx.toInt(),
                ];

                var end = [
                  newItemEnd!.dy.toInt(),
                  newItemEnd!.dx.toInt(),
                ];

                print([start, end]);
                //[0]  = .dy 1 = .dx
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
                          (task["endRow"] >= endRow &&
                              task["endRow"] <= endRow)) &&
                      ((task["startCol"] >= startCol &&
                              task["startCol"] <= endCol) ||
                          (task["endCol"] >= startCol &&
                              task["endCol"] <= endCol));
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
        ),
        if (dragging)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            top: tileHeight * (math.min(newItemStart!.dy, newItemEnd!.dy) - 1),
            left: tileWidth * (math.min(newItemStart!.dx, newItemEnd!.dx) - 1),
            width: tileWidth *
                (math.max(newItemEnd!.dx - newItemStart!.dx,
                        newItemStart!.dx - newItemEnd!.dx) +
                    1),
            height: tileHeight *
                (math.max(newItemEnd!.dy - newItemStart!.dy,
                        newItemStart!.dy - newItemEnd!.dy) +
                    1),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red
                    .withOpacity(0.1), // add your desired background color here
                borderRadius: BorderRadius.circular(
                    10.0), // add your desired border radius here
              ),
            ),
          ),
      ],
    );
  }
}
