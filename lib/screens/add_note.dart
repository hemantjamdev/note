import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
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
