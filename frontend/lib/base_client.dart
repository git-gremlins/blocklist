import 'package:frontend/get_parse.dart';
import 'package:http/http.dart' as http;

class BaseClient {
  var client = http.Client();
  Future<dynamic> get() async {
    var url = Uri.parse("http://localhost:4000/tasks.get");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      var dataObject = tasksFromJson(response.body);
      var tasks = dataObject.result.data;
      return tasks;
    } else {}
  }
}
