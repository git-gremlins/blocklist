import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'package:frontend/types/task/add_task.dart';
import 'package:spannable_grid/spannable_grid.dart';
import 'dart:math' as math;

class TaskSpannableGridCells extends StatefulWidget {
  final List<SpannableGridCellData> taskCells;
  final List<dynamic> tasks;
  const TaskSpannableGridCells(
      {super.key, required this.taskCells, required this.tasks});

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
      showGrid: false,
      emptyCellView: GestureDetector(
        onPanStart: (details) => {
          print(
              "Start ${getParentRenderObject().globalToLocal(details.globalPosition)}"),
          setState(() {
            newItemStart =
                getParentRenderObject().globalToLocal(details.globalPosition);
          })
        },
        onPanUpdate: (details) => {
          // print("Size of widget ${_getSize()}"),
          // print("Location of start ${details.localPosition}"),
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

            int startRow = math.min(start[0], end[0]) - 1;
            int startCol = math.min(start[1], end[1]) - 1;
            int endRow = math.min(math.max(start[0], end[0]) - 1, 7);
            int endCol = math.min(math.max(start[1], end[1]) - 1, 3);
            int dragEndRow = math.min(end[0] - 1, 7);
            int dragEndCol = math.min(end[1] - 1, 3);

            if (supabase.auth.currentUser == null) return;
            // print({
            //   "task width": tileWidth,
            //   "task height": tileHeight,
            //   "start row": start[0],
            //   "end row": end[0],
            //   "start col": start[1],
            //   "end col": end[1]
            // });
            List<bool> collisions = widget.tasks.map((task) {
              return dragEndRow >= task["startRow"] &&
                  dragEndRow <= task["endRow"] &&
                  dragEndCol >= task["startCol"] &&
                  dragEndCol <= task["endCol"];
            }).toList();
            print(collisions);
            if (collisions.contains(true)) return;
            Future<dynamic> _postedTask = postTask(
              AddTask(
                name: "test task",
                description: "Just this for now",
                userId: supabase.auth.currentUser!.id,
                importance: "medium",
                startRow: startRow,
                startCol: startCol,
                endRow: endRow,
                endCol: endCol,
              ),
            );

            // print("Start: Y:${start[0] - 1} X:${start[1] - 1}");
            // print("End:  Y:${end[0] - 1} X:${end[1] - 1}");
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
