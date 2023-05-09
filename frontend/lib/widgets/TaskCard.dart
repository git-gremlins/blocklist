import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/screens/sub_tasks.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:frontend/types/task/delete_task.dart';
import 'package:frontend/types/task/update_task.dart';

import '../helpers/colour_choice.dart';

class TaskCard extends StatefulWidget {
  final dynamic task;

  TaskCard({
    super.key,
    required this.task,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task["name"]);
    _descriptionController =
        TextEditingController(text: widget.task["description"]);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      updateTask(UpdateTask(
          taskId: widget.task["taskId"],
          name: _titleController.text,
          description: _descriptionController.text));
    }
  }

  Widget _editTitleTextField() {
    return AlertDialog(
      title: const Text('Edit your task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'change task name';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Task',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'change your description';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await deleteTask(RemoveTask(taskId: widget.task["taskId"]));
              },
              child: const Text('Delete Task'),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Submit'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubTaskScreen(
                task: widget.task,
              ),
            ));
      },
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: ((context) {
            return _editTitleTextField();
          }),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colourChoice(widget.task["endRow"], widget.task["startRow"],
                widget.task["endCol"], widget.task["startCol"])),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: AutoSizeText(
                  widget.task["name"],
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  maxFontSize: 22,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: AutoSizeText(
                  widget.task["description"],
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                  maxFontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
