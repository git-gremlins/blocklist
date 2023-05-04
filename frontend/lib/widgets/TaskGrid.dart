import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend/api.dart';
import 'package:frontend/widgets/FutureData.dart';
import 'dart:math' as math;

class TaskGrid extends StatefulWidget {
  const TaskGrid({super.key});

  @override
  State<TaskGrid> createState() => _TaskGrid();
}

class _TaskGrid extends State<TaskGrid> {
  final Future<List<dynamic>> _parentTasks =
      Future.delayed(const Duration(seconds: 1), () => getParentTasks("1"));

  @override
  Widget build(BuildContext context) {
    return FutureData<Widget, List<dynamic>>(
        future: _parentTasks,
        onDataCallback: (tasks) {
          return MasonryGridView.builder(
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                if (tasks[index]["importance"] == "low") {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 150,
                      child: ColoredBox(
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Text(tasks[index]["name"])),
                    ),
                  );
                }
                if (tasks[index]["importance"] == "medium") {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 300,
                      child: ColoredBox(
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Text(tasks[index]["name"])),
                    ),
                  );
                }

                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 450,
                    child: ColoredBox(
                        color: Color(
                                (math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                        child: Text(tasks[index]["name"])),
                  ),
                );
              });
        },
        onReturnCallback: (result) => result,
        onErrorCallback: (error) => Text("Error: $error"),
        loadingValue: const Center(child: CircularProgressIndicator()));
  }
}
