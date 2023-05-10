import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/types/task/delete_task.dart';
import 'package:frontend/types/task/update_task.dart';

class UpdateTaskForm extends StatefulWidget {
  dynamic task;
  UpdateTaskForm({super.key, required this.task});

  @override
  State<UpdateTaskForm> createState() => _UpdateTaskFormState();
}

class _UpdateTaskFormState extends State<UpdateTaskForm> {
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

  @override
  Widget build(BuildContext context) {
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
                // if (value!.isEmpty) {
                //   return 'change your description';
                // }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'optional',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Update'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Positioned(
        //   top: 20,
        //   left: 20,
        //   child: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(Icons.close),
        //   ),
        // ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
            await deleteTask(RemoveTask(taskId: widget.task["taskId"]));
          },
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 10),
              Text('Delete / Complete Task'),
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.red.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        )
      ],
    );
  }
}
