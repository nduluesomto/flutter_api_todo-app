import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_todo_app/services/api_service.dart';
import 'package:flutter_api_todo_app/views/edit_note.dart';
import 'package:get/get.dart';

import '../models/todo_model.dart';
import '../views/add_note.dart';

class AppController extends GetxController {
  //var toDoList = <ToDoModel>[].obs;
  var isLoading = true.obs;
  var editPage = true.obs;

  ToDoModel? toDoModel;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    fetchToDoList();

    super.onInit();
  }

  fetchToDoList() async {
    try {
      isLoading(true);
      var response = await ApiService.client.get(Uri.parse(ApiService.url));

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        toDoModel = ToDoModel.fromJson(jsonString);

        update();
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
    return null;
  }

  Future<void> deleteById(id) async {
    final deleteUrl = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(deleteUrl);
    final response = await ApiService.client.delete(uri);
    if (response.statusCode == 200) {
      fetchToDoList();
      //update();
    } else {}
  }

  void goToAddPage() {
    Get.to(() => AddNote());
  }

  Future<void> editToPage({required int index}) async {
    final title = controller.toDoModel!.items[index].title;
    final description = controller.toDoModel!.items[index].description;

    controller.titleController.text = title!;
    controller.descriptionController.text = description!;

    Get.to(() => EditPage(index: index));
  }

  void saveTodo() {
    final title = titleController.text;
    final description = descriptionController.text;

    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    ApiService.submitData(body);
    Get.back();
    fetchToDoList();
    update();
  }

  void editToDo({required String id}) {
    final title = titleController.text;
    final description = descriptionController.text;

    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    ApiService.updateData(body, id);
    Get.back();
    fetchToDoList();
    update();
  }

  void successMessage(String message) {
    Get.snackbar("Success", message, snackPosition: SnackPosition.BOTTOM);
  }

  void errorMessage(String message) {
    Get.snackbar("Failed", message);
  }

  void disposeControllers() {
    titleController.clear();
    descriptionController.clear();
  }
}
