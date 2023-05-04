import 'package:frontend/helpers/http_client.dart';
import 'package:frontend/types/task/delete_task.dart';
import 'package:frontend/types/task/task.dart';
import 'package:frontend/types/task/update_task.dart';

Future getTaskTree(int taskId) {
  return BaseClient().get("tasks.get.taskAndChildren?input=$taskId");
}

Future<List<dynamic>> getParentTasks(String userId) async {
  return await BaseClient().get('userTasks.get.parentTasks?input="$userId"');
}

Future<Task> updateTask(UpdateTask task) async {
  return await BaseClient().patch<Task>("tasks.update.task", task);
}

Future<Task> deleteTask(RemoveTask task) async {
  return await BaseClient().delete("tasks.remove.task", task);
}
