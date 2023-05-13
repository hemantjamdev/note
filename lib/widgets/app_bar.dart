import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/constants/strings.dart';
import 'package:note/widgets/delete_all.dart';

import 'edit_title.dart';
import 'g_backup.dart';

AppBar buildAppBar(
    {required BuildContext context,
    String? title,
    bool isHome = false,
    bool night = false}) {
  return AppBar(
    leading: isHome ? backup(context) : null,
    elevation: 0,
    backgroundColor: night ? Colors.black54 : Colors.white,
    automaticallyImplyLeading: false,
    title: Hero(
      tag: Strings.titleHero,
      child: GestureDetector(
        onTap: () {
          if (isHome) if (context.mounted) saveTitle(context, title);
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
              ),
      ),
    ),
    centerTitle: true,
    actions: [
      isHome && (context.mounted)
          ? buildDeleteAll(context: context)
          : const SizedBox(),
    ],
  );
}
