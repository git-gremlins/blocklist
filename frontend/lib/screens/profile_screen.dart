import 'package:flutter/material.dart';
import 'package:frontend/api.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/FutureData.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController? _nameController;
  TextEditingController? _surnameController;
  Future<dynamic> user = getUser(userId: supabase.auth.currentUser!.id);
  final _formKey = GlobalKey();

  @override
  void dispose() {
    _nameController?.dispose();
    _surnameController?.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final String name = _nameController!.text;
    final String surname = _surnameController!.text;
    print(supabase.auth.currentUser!.id);
    user = updateUser(UpdateUser(
        userId: supabase.auth.currentUser!.id, name: name, surname: surname));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureData<List<Widget>, dynamic>(
              future: user,
              onDataCallback: (data) {
                _nameController = TextEditingController(text: data["name"]);
                _surnameController =
                    TextEditingController(text: data["surname"]);
                return <Widget>[
                  const Text(
                    "Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Surname",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _surnameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your surname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    child: const Text("Submit"),
                  ),
                ];
              },
              onReturnCallback: (value) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: value),
                  ),
              onErrorCallback: (err) => <Widget>[Text(err.toString())],
              loadingValue: const <Widget>[Text("Loading...")]),
        ),
      ),
    );
  }
}
