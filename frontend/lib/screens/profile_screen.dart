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

  @override
  void dispose() {
    _nameController?.dispose();
    _surnameController?.dispose();
    super.dispose();
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
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
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
                  TextField(
                    controller: _surnameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ];
              },
              onReturnCallback: (value) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: value),
              onErrorCallback: (err) => <Widget>[Text(err.toString())],
              loadingValue: const <Widget>[Text("Loading...")]),
        ),
      ),
    );
  }
}
