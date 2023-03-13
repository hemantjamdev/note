import 'package:flutter/material.dart';
import 'package:note/constants/strings.dart';

Future<bool> confirmation(
    {required BuildContext context, required String text}) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(Strings.confirm),
        content: Text("${Strings.areYourSure} $text"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(Strings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text(Strings.delete),
          ),
        ],
      );
    },
  );
}
