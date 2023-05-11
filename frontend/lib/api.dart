import 'package:frontend/helpers/http_client.dart';

import 'package:frontend/types/generic/json_types.dart';

import 'package:frontend/types/task/add_task.dart';

import 'package:frontend/types/task/delete_task.dart';

import 'package:frontend/types/task/update_task.dart';

Future getTaskTree(int taskId) {
  return BaseClient().get("tasks.get.taskAndChildren?input=$taskId");
}

Future<List<dynamic>> getParentTasks(String userId) async {
  return await BaseClient().get('userTasks.get.parentTasks?input="$userId"');
}

Future<dynamic> updateTask(UpdateTask task) async {
  return await BaseClient().patch<dynamic>("tasks.update.task", task);
}

Future<dynamic> deleteTask(RemoveTask task) async {
  return await BaseClient().delete("tasks.remove.task", task);
}

Future<dynamic> postTask(AddTask task) async {
  return await BaseClient().post("tasks.post.task", task);
}

Future<dynamic> getUser({required String userId}) async {
  return await BaseClient().get('users.get.user?input="$userId"');
}

Future<dynamic> postUser(InputUser user) async {
  return await BaseClient().post("users.post.user", user);
}

Future<dynamic> updateUser(UpdateUser user) async {
  return await BaseClient().patch("users.update.user", user);
}

class InputUser extends JSONMutationObject {
  String userId;

  String name;

  String surname;

  InputUser({required this.userId, required this.name, required this.surname});

  @override
  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["userId"] = userId;

    data["name"] = name;

    data["surname"] = surname;

    return data;
  }
}

class UpdateUser extends JSONMutationObject {
  String userId;

  String? name;

  String? surname;

  String? email;

  UpdateUser({required this.userId, this.name, this.surname, this.email});

  @override
  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["userId"] = userId;

    if (name != null) data["name"] = name;

    if (surname != null) data["surname"] = surname;

    if (email != null) data["email"] = email;

    return data;
  }
}
