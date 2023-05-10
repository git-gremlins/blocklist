import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'package:frontend/types/task/add_task.dart';
import 'package:frontend/types/task/update_task.dart';
import 'package:frontend/widgets/Update_task_form.dart';
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

  late List<int> start, end;
  late int startRow, startCol, endRow, endCol;
  late List<bool> collisions;
  @override
  Widget build(BuildContext context) {
    if (dragging) {
      start = [
        newItemStart!.dy.toInt(),
        newItemStart!.dx.toInt(),
      ];

      end = [
        newItemEnd!.dy.toInt(),
        newItemEnd!.dx.toInt(),
      ];

      startRow = math.max(math.min(start[0], end[0]) - 1, 0);
      startCol = math.max(math.min(start[1], end[1]) - 1, 0);
      endRow = math.max(math.min(math.max(start[0], end[0]) - 1, 7), 0);
      endCol = math.max(math.min(math.max(start[1], end[1]) - 1, 3), 0);
      if (supabase.auth.currentUser != null) {
        collisions = widget.tasks.map((task) {
          return (task["startRow"] <= startRow + (endRow - startRow)) &&
              (task["startRow"] + (task["endRow"] - task["startRow"]) >=
                  startRow) &&
              (task["startCol"] <= startCol + (endCol - startCol)) &&
              ((task["endCol"] - task["startCol"]) + task["startCol"] >=
                  startCol);
        }).toList();
      }
    }
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

              var startPos = Offset((position.dx / tileWidth).ceil().toDouble(),
                  (position.dy / tileWidth).ceil().toDouble());
              setState(() {
                newItemStart = startPos;
                newItemEnd = startPos;
                dragging = true;
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
            onPanEnd: (details) async {
              setState(() {
                dragging = false;
              });

              if (newItemEnd != null) {
                if (collisions.contains(true)) return;
                dynamic postedTask = await postTask(
                  AddTask(
                    name: "",
                    description: "",
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
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: ((context) {
                    return UpdateTaskForm(task: postedTask);
                  }),
                );
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
                //collisions.contains(true)
                color: !collisions.contains(true)
                    ? Colors.indigo.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.0),

                gradient: collisions.contains(true)
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(-0.4, -0.8),
                        stops: [0.0, 0.5, 0.5, 1],
                        colors: [
                          Colors.redAccent,
                          Colors.redAccent,
                          Colors.amber,
                          Colors.amber,
                        ],
                        tileMode: TileMode.repeated,
                      )
                    : null,
              ),
            ),
          ),
      ],
    );
  }
}
