import 'package:flutter/material.dart';
import 'package:note/constants/app_icons.dart';
import 'package:note/constants/strings.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/model/note_model.dart';
import 'package:note/widgets/app_bar.dart';

class EditNote extends StatefulWidget {
  final NoteModel noteModel;

  const EditNote({Key? key, required this.noteModel}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late TextEditingController _titleController;
  late TextEditingController _discController;
  final FocusNode _discFocus = FocusNode();
  final dbHelper = DBHelper();

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.noteModel.title);
    _discController = TextEditingController(text: widget.noteModel.disc);
    super.initState();
  }

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
          dbHelper
              .update(
                  key: widget.noteModel.key,
                  title: _titleController.text,
                  disc: _discController.text)
              .then((value) => {Navigator.pop(context)});
        },
        child:AppIcons.done,
      ),
      appBar:
          buildAppBar(context: context, title: Strings.editNote, isHome: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              focusNode: _discFocus,
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
                autofocus: true,
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
