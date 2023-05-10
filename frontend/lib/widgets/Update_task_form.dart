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

  void _clearDescription() {
    _descriptionController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: AlertDialog(
        title: const Text(
          'Edit your task',
          style: TextStyle(fontSize: 12),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'add task name';
                  }
                  return null;
                },
                style: TextStyle(
                  fontSize: 10,
                ),
                decoration: InputDecoration(
                  labelText: 'Task',
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 10,
                style: TextStyle(
                  fontSize: 10,
                ),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  hintText: 'add a description',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Update'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await deleteTask(RemoveTask(taskId: widget.task["taskId"]));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Remove Task'),
          ),
        ],
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: AlertDialog(
//         title: const Text('Edit your task'),
//         content: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'change task name';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Task',
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _descriptionController,
//                 validator: (value) {
//                   // if (value!.isEmpty) {
//                   //   return 'change your description';
//                   // }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Description',
//                   hintText: 'optional',
//                 ),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: const Text('Update'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.green.withOpacity(0.5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: _clearDescription,
//             child: const Text('Clear description'),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.grey.withOpacity(0.5),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await deleteTask(RemoveTask(taskId: widget.task["taskId"]));
//             },
//             child: Row(
//               children: [
//                 Icon(Icons.delete),
//                 SizedBox(width: 10),
//                 Text('Delete / Complete Task'),
//               ],
//             ),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.red.withOpacity(0.5),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
