import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'package:frontend/types/task/add_task.dart';
import 'package:spannable_grid/spannable_grid.dart';
import 'dart:math' as math;

class TaskSpannableGridCells extends StatefulWidget {
  final List<SpannableGridCellData> taskCells;
  const TaskSpannableGridCells({super.key, required this.taskCells});

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
        print('Cell ${cell?.id} changed');
      },
      showGrid: false,
      emptyCellView: GestureDetector(
        // key: Key("${math.Random()}"),
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
            if (supabase.auth.currentUser == null) return;
            var _postedTask = postTask(
              AddTask(
                  name: "test task",
                  description: "Just this for now",
                  userId: supabase.auth.currentUser!.id,
                  importance: "medium",
                  startRow: start[0] - 1,
                  startCol: start[1] - 1,
                  endRow: end[0] - 1,
                  endCol: end[1] - 1),
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
