import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/app_controller.dart';

class AddNote extends StatelessWidget {
  AddNote({
    Key? key,
  }) : super(key: key);

  final AppController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Add Task', style: TextStyle(color: Colors.black)),
          leading: IconButton(
              onPressed: () {
                Get.back();
                controller.fetchToDoList();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              children: [
                TextField(
                    controller: controller.titleController,
                    decoration: const InputDecoration(hintText: "Title")),
                const SizedBox(height: 20),
                TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 10,
                    controller: controller.descriptionController,
                    decoration: const InputDecoration(hintText: 'Description')),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    controller.saveTodo();
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text('Submit',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)))),
                ),
              ],
            )));
  }
}
