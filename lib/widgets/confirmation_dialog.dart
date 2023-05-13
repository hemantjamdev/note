import 'package:flutter/material.dart';

Future<bool?> confirmation({
  required BuildContext context,
  required String title,
  required String confirm,
  required String cancel,
  required String content,
}) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (context.mounted) Navigator.of(context).pop(true);
            },
            child: Text(confirm),
          ),
        ],
      );
    },
  );
}
