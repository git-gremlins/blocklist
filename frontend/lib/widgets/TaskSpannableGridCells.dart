import 'package:flutter/material.dart';
import 'package:spannable_grid/spannable_grid.dart';

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

  RenderBox temp() {
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
      showGrid: true,
      emptyCellView: GestureDetector(
        onPanStart: (details) => {
          // print("Start ${_getSize()}"),
          setState(() {
            newItemStart = details.localPosition;
          })
        },
        onPanUpdate: (details) => {
          // print("Size of widget ${_getSize()}"),
          // print("Location of start ${details.localPosition}"),
          setState(() {
            newItemEnd = details.localPosition;
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

            // print("Start: Y:${start[0] - 1} X:${start[1] - 1}");
            // print("End:  Y:${end[0] - 1} X:${end[1] - 1}");
          }
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ),
      ),
    );
  }
}
