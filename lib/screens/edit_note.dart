import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  const EditNote({Key? key}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("note title"),
      ),
      body: Column(
        children: const [
          TextField(
            decoration: InputDecoration(hintText: "Title"),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: "Description"),
            ),
          )
        ],
      ),
    );
  }
}
