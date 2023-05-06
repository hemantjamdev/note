import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/constants/strings.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/widgets/delete_all.dart';

import '../model/note_model.dart';

AppBar buildAppBar(
    {required BuildContext context, String? title, bool isHome = false}) {
  log("---> is home ----${isHome.toString()}<<----");
  return AppBar(
    automaticallyImplyLeading: false,
    title: Hero(
      tag: Strings.titleHero,
      child: GestureDetector(
          onTap: () {
            if (isHome) saveTitle(context, title);
          },
          child: isHome
              ? ValueListenableBuilder(
                  valueListenable: Hive.box<String>("titleData").listenable(),
                  builder: (context, Box<String> box, widget) {
                     if(box.values.isNotEmpty){
                       log("title data lengh--->${box.values.length}");
                       log("title data lengh--->${box.keys.toList()}");
                       log("title data lengh--->${box.values.length}");
                       return Text(
                        box.values.first.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                       );
                    }else{
                       return Text(
                         "Your Notes",
                         style: Theme.of(context).textTheme.titleLarge,
                       );
                     }
                        /*?
                        : Text(
                            "Your Notes",
                            style: Theme.of(context).textTheme.titleLarge,
                          );*/
                  })
              : Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge,
                )),
    ),
    centerTitle: true,
    actions: [
      isHome
          ? buildDeleteAll(context: context, text: Strings.allItem)
          : const SizedBox(),
    ],
  );
} /*

Future<String> getTitle() async {
  DBHelper dbHelper = DBHelper();
  NoteModel? titleNote = await dbHelper.getNoteByKey("title");
  String title = titleNote!.title;
  return title;
}*/

saveTitle(BuildContext context, String? title) async {
  TextEditingController controller = TextEditingController();
  DBHelper dbHelper = DBHelper();
  bool update = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Update Title"),
        content: TextField(
          onSubmitted: (value) => Navigator.pop(context, true),
          controller: controller,
          maxLength: 10,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Update")),
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel")),
        ],
      );
    },
  );
  update ? dbHelper.saveTitle(controller.text) : null;
}
