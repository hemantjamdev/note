import 'package:flutter/material.dart';
import 'package:note/constants/strings.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/widgets/app_bar.dart';
import 'package:note/widgets/toast.dart';

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
  void dispose() {
    _titleController.dispose();
    _discController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: Strings.fabHero,
        onPressed: () {
          if (_titleController.text.isEmpty && _discController.text.isEmpty) {
            buildToast(text: Strings.noteDiscard);
            Navigator.pop(context);
          } else {
            dbHelper
                .add(title: _titleController.text, disc: _discController.text)
                .then((value) => {Navigator.pop(context)});
          }
        },
        child: const Icon(Icons.done),
      ),
      appBar:
          buildAppBar(context: context, title: Strings.addNote, isHome: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              onSubmitted: (String text) {
                FocusScope.of(context).requestFocus(_discFocus);
              },
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: Strings.hintTitle,
                hintStyle: TextStyle(fontSize: 32),
              ),
            ),
            Expanded(
              child: TextField(
                focusNode: _discFocus,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                controller: _discController,
                decoration: const InputDecoration(hintText: Strings.hintDesc),
              ),
            )
          ],
        ),
      ),
    );
  }
}
