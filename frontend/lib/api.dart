import 'package:frontend/helpers/http_client.dart';

Future<dynamic> getTaskTree(int taskId) {
  return BaseClient().get("tasks.get.taskAndChildren?input=$taskId");
}

Future<dynamic> getParentTasks() async {
  return await BaseClient().get("tasks.get.parentTasks");
}
