import 'package:flutter/material.dart';
import 'package:flutter_api_todo_app/controllers/app_controller.dart';
import 'package:get/get.dart';

import '../widgets/note_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Task List'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[700],
        onPressed: () {
          controller.goToAddPage();
        },
        child: const Text("Add"),
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Visibility(
              visible: controller.toDoModel!.items.isNotEmpty,
              replacement: const Center(
                  child:
                      Text('No recorded Task', style: TextStyle(fontSize: 23))),
              child: ListView.builder(
                  // physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  //itemCount: controller.toDoList.length,
                  itemCount: controller.toDoModel!.items.length,
                  itemBuilder: (context, index) {
                    return NoteWidget(index: index);
                  }),
            )),
    );
  }
}
