import 'package:frontend/types/generic/json_types.dart';

class UpdateTask extends JSONMutationObject {
  int taskId;
  String? name;
  String? description;
  int? parentTaskId;
  int? userId;
  String? importance;
  String? deadline;

  UpdateTask(
      {required this.taskId,
      this.name,
      this.description,
      this.parentTaskId,
      this.userId,
      this.importance,
      this.deadline});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskId'] = taskId;
    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;
    if (parentTaskId != null) data['parentTaskId'] = parentTaskId;
    if (userId != null) data['userId'] = userId;
    if (importance != null) data['importance'] = importance;
    if (deadline != null) data['deadline'] = deadline;
    return data;
  }
}
