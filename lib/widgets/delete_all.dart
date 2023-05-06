import 'package:flutter/material.dart';
import 'package:note/constants/app_icons.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/widgets/confirmation_dialog.dart';

Widget buildDeleteAll({required BuildContext context, required String text}) {
  DBHelper dbHelper = DBHelper();
  return IconButton(
    icon:Icon(Icons.delete,),
    onPressed: () {
      confirmation(context: context, text: text).then((value) {
        if (value) {
          dbHelper.deleteAll();
        }
      });
    },
  );
}
