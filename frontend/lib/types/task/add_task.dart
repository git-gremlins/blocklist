import 'package:frontend/types/generic/json_types.dart';

class AddTask extends JSONMutationObject {
  String name;
  String description;
  int? parentTaskId;
  String userId;
  String importance;
  String? deadline;
  int startRow;
  int startCol;
  int endRow;
  int endCol;

  AddTask({
    required this.name,
    required this.description,
    this.parentTaskId,
    required this.userId,
    required this.importance,
    this.deadline,
    required this.startRow,
    required this.startCol,
    required this.endRow,
    required this.endCol,
  });

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    if (parentTaskId != null) data['parentTaskId'] = parentTaskId;
    data['userId'] = userId;
    data['importance'] = importance;
    if (deadline != null) data['deadline'] = deadline;
    data['startRow'] = startRow;
    data['startCol'] = startCol;
    data['endRow'] = endRow;
    data['endCol'] = endCol;
    return data;
  }
}
