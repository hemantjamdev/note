import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/constants/strings.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/widgets/delete_all.dart';

AppBar buildAppBar(
    {required BuildContext context,
    String? title,
    bool isHome = false,
    bool night = false}) {
  return AppBar(
    elevation: 0,
    backgroundColor: night ? Colors.black54 : Colors.white,
    automaticallyImplyLeading: false,
    title: Hero(
      tag: Strings.titleHero,
      child: GestureDetector(
          onTap: () {
            if (isHome) saveTitle(context, title);
          },
          child: isHome
              ? ValueListenableBuilder(
                  valueListenable:
                      Hive.box<String>(Strings.titleDatabaseName).listenable(),
                  builder: (context, Box<String> box, widget) {
                    if (box.values.isNotEmpty) {
                      return Text(
                        "${box.values.first.toString()}'s notes",
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    } else {
                      return Text(
                        Strings.noteList,
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    }
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
}

saveTitle(BuildContext context, String? title) async {
  TextEditingController controller = TextEditingController();
  DBHelper dbHelper = DBHelper();
  bool update = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(Strings.updateTitle),
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
              child: const Text(Strings.update)),
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(Strings.cancel)),
        ],
      );
    },
  );
  update && controller.text.isNotEmpty
      ? dbHelper.saveTitle(controller.text)
      : null;
}
