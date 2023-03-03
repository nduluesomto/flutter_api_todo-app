import 'package:flutter/material.dart';
import 'package:flutter_api_todo_app/controllers/app_controller.dart';
import 'package:get/get.dart';

class NoteWidget extends StatelessWidget {
  int index;

  final AppController controller = Get.find();

  NoteWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String title = '';
    //
    // title = controller.toDoModel!.items[index].title;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child:
              Text('${index + 1}', style: const TextStyle(color: Colors.white)),
        ),
        title: Text(controller.toDoModel!.items[index].title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600)),
        subtitle: Text(controller.toDoModel!.items[index].description,
            style: const TextStyle(color: Colors.black)),
        trailing: PopupMenuButton(onSelected: (value) {
          if (value == 'delete') {
            controller.deleteById(controller.toDoModel!.items[index].id);
          } else if (value == 'edit') {
            controller.editToPage(index: index);
            // Get.to(() => EditPage(index: index));
          }
        },
            //color: Colors.white,
            itemBuilder: (context) {
          return [
            const PopupMenuItem(child: Text('Edit'), value: 'edit'),
            const PopupMenuItem(child: Text('Delete'), value: 'delete')
          ];
        }),
      ),
    );

    //   ListTile(
    //   title: Text(controller.toDoModel!.items[index].description),
    // );
  }
}
