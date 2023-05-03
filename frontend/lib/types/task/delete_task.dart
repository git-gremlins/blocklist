import 'package:frontend/types/generic/json_types.dart';

class RemoveTask extends JSONMutationObject {
  int taskId;
  RemoveTask({required this.taskId});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskId'] = taskId;
    return data;
  }
}
