import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/constants/local_storage.dart';
import 'package:note/model/note_model.dart';
import 'package:note/widgets/add_bar.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discController = TextEditingController();
  final FocusNode _discFocus = FocusNode();
  final dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'hi',
        onPressed: ()  {
          dbHelper
              .add(title: _titleController.text, disc: _discController.text)
              .then((value) => {Navigator.pop(context)});
        },
        child: Icon(Icons.done),
      ),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:Hero(tag:'title',child:Text('Add Note',style: Theme.of(context).textTheme.titleMedium,)) ,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (String text) {
                FocusScope.of(context).requestFocus(_discFocus);
              },
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(fontSize: 32),
              ),
            ),
            Expanded(
              child: TextField(
                focusNode: _discFocus,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                controller: _discController,
                decoration: InputDecoration(hintText: "Description"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
