import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:supabase/supabase.dart';

class PopUpForm extends StatefulWidget {
  const PopUpForm({super.key});

  @override
  _PopUpFormState createState() => _PopUpFormState();
}

class _PopUpFormState extends State<PopUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  String _selectedValue = "medium";

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Make Supabase request with input and selected value
      await supabase
          .from('tasks')
          .insert({'task': _textController.text, 'Priority': _selectedValue});
      // Close pop-up form
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add item'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _textController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Add a task';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Task',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value!;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'select a priority';
                }
                return null;
              },
              items: const [
                DropdownMenuItem(
                  value: 'high',
                  child: Text('high'),
                ),
                DropdownMenuItem(
                  value: 'medium',
                  child: Text('medium'),
                ),
                DropdownMenuItem(
                  value: 'low',
                  child: Text('low'),
                )
              ],
              decoration: const InputDecoration(
                labelText: 'Dropdown menu',
              ),
            ),
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
