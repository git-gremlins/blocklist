import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import '../main.dart';
import '../types/task/add_task.dart';

class PostTaskForm extends StatefulWidget {
  dynamic parentTask;
  dynamic startRow;
  dynamic startCol;
  dynamic endRow;
  dynamic endCol;
  PostTaskForm(
      {super.key,
      this.parentTask,
      required this.startRow,
      required this.endRow,
      required this.startCol,
      required this.endCol});

  @override
  State<PostTaskForm> createState() => _PostTaskFormState();
}

class _PostTaskFormState extends State<PostTaskForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: "");
    _descriptionController = TextEditingController(text: "");
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
      postTask(AddTask(
        name: _titleController.text,
        description: _descriptionController.text,
        userId: supabase.auth.currentUser!.id,
        parentTaskId:
            widget.parentTask == null ? null : widget.parentTask!["taskId"],
        startRow: widget.startRow,
        startCol: widget.startCol,
        endRow: widget.endRow,
        endCol: widget.endCol,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create your task'),
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
}
