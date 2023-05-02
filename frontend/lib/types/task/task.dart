import 'package:frontend/types/generic/json_types.dart';

class Task extends JSONMutationObject {
  int? taskId;
  String? name;
  String? description;
  int? parentTaskId;
  int? userId;
  String? importance;
  String? deadline;

  Task(
      {required this.taskId,
      required this.name,
      required this.description,
      this.parentTaskId,
      required this.userId,
      required this.importance,
      this.deadline});

  Task.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    name = json['name'];
    description = json['description'];
    parentTaskId = json['parentTaskId'];
    userId = json['userId'];
    importance = json['importance'];
    deadline = json['deadline'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskId'] = taskId;
    data['name'] = name;
    data['description'] = description;
    data['parentTaskId'] = parentTaskId;
    data['userId'] = userId;
    data['importance'] = importance;
    data['deadline'] = deadline;
    return data;
  }
}
