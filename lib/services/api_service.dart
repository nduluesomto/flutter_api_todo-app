import 'dart:convert';

import 'package:flutter_api_todo_app/controllers/app_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final AppController controller = Get.find();

class ApiService {
  static var client = http.Client();
  static const url = 'http://api.nstack.in/v1/todos?page=1&limit=20';

  static var header = {'Content-Type': 'application/json'};

  static Future<void> submitData(body) async {
    const postUrl = 'http://api.nstack.in/v1/todos';
    final response = await client.post(Uri.parse(postUrl),
        body: jsonEncode(body), headers: header);
    if (response.statusCode == 201) {
      controller.successMessage('Task Added');
      controller.disposeControllers();
    } else {
      controller.errorMessage('Failed to add task');
    }
    // print(response.statusCode);
    // print(response.body);
  }

  static Future<void> updateData(body, String id) async {
    final updateUrl = 'http://api.nstack.in/v1/todos/$id';
    final response = await client.put(Uri.parse(updateUrl),
        body: jsonEncode(body), headers: header);
    if (response.statusCode == 200) {
      controller.successMessage('Task Updated');
      controller.disposeControllers();
    } else {
      controller.errorMessage('Failed to updated');
      // print(response.body);
    }
  }
}
