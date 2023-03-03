import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/app_controller.dart';

class EditPage extends StatelessWidget {
  final index;
  EditPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  AppController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    // final title = controller.toDoModel?.items[index].title;
    // final description = controller.toDoModel?.items[index].description;
    //
    // controller.titleController.text = title!;
    // controller.descriptionController.text = description!;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Edit Task', style: TextStyle(color: Colors.black)),
          leading: IconButton(
              onPressed: () {
                Get.back();
                controller.fetchToDoList();
                controller.disposeControllers();
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
                    controller.editToDo(
                        id: controller.toDoModel!.items[index].id);
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text('Edit',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)))),
                ),
              ],
            )));
  }
}
