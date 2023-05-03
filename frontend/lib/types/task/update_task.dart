import 'package:frontend/types/generic/json_types.dart';

class UpdateTask extends JSONMutationObject {
  int taskId;
  String? name;
  String? description;
  int? parentTaskId;
  int? userId;
  String? importance;
  String? deadline;
  int? startRow;
  int? startCol;
  int? endRow;
  int? endCol;

  UpdateTask({
    required this.taskId,
    this.name,
    this.description,
    this.parentTaskId,
    this.userId,
    this.importance,
    this.deadline,
    this.startRow,
    this.startCol,
    this.endRow,
    this.endCol,
  });

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
    if (startRow != null) data['startRow'] = startRow;
    if (startCol != null) data['startCol'] = startCol;
    if (endRow != null) data['endRow'] = endRow;
    if (endCol != null) data['endCol'] = endCol;
    return data;
  }
}
