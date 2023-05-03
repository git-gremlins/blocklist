import 'package:frontend/helpers/http_client.dart';
import 'package:frontend/types/task/task.dart';
import 'package:frontend/types/task/update_task.dart';

Future getTaskTree(int taskId) {
  return BaseClient().get("tasks.get.taskAndChildren?input=$taskId");
}

Future getParentTasks() async {
  return await BaseClient().get("tasks.get.parentTasks");
}

Future<Task> updateTask(UpdateTask task) async {
  return await BaseClient().patch<Task>("tasks.update.task", task);
}
