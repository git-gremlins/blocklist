// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'dart:convert';

Tasks tasksFromJson(String str) => Tasks.fromJson(json.decode(str));

String tasksToJson(Tasks data) => json.encode(data.toJson());

class Tasks {
  Result result;

  Tasks({
    required this.result,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class Result {
  List<Datum> data;

  Result({
    required this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int taskId;
  String name;
  String description;
  dynamic parentTaskId;

  Datum({
    required this.taskId,
    required this.name,
    required this.description,
    this.parentTaskId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        taskId: json["taskId"],
        name: json["name"],
        description: json["description"],
        parentTaskId: json["parentTaskId"],
      );

  Map<String, dynamic> toJson() => {
        "taskId": taskId,
        "name": name,
        "description": description,
        "parentTaskId": parentTaskId,
      };
}
