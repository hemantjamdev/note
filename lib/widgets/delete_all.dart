import 'package:flutter/material.dart';
import 'package:note/constants/strings.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/widgets/confirmation_dialog.dart';

Widget buildDeleteAll({required BuildContext context}) {
  DBHelper dbHelper = DBHelper();
  return IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      if (context.mounted) {
        bool? value = await confirmation(
            content: Strings.areYourSure,
            context: context,
            title: Strings.delete,
            cancel: Strings.cancel,
            confirm: Strings.confirm);
        if (value != null && value) {
          dbHelper.deleteAll();
        }
      }
    },
  );
}
