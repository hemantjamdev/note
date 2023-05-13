import 'package:flutter/material.dart';
import 'package:note/constants/strings.dart';
import 'package:note/local_storage/local_storage.dart';
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