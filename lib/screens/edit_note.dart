import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/constants/local_storage.dart';
import 'package:note/model/note_model.dart';
import 'package:note/widgets/add_bar.dart';

class EditNote extends StatefulWidget {
  final NoteModel noteModel;

  const EditNote({Key? key, required this.noteModel}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late  TextEditingController _titleController;

  late  TextEditingController _discController;

  final FocusNode _discFocus = FocusNode();

  final dbHelper= DBHelper();
  @override
  void initState() {
   _titleController= TextEditingController(text: widget.noteModel.title ?? "");
    _discController=TextEditingController(text: widget.noteModel.disc ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'hi',
        onPressed: ()  {
          dbHelper
              .update(key:widget.noteModel.key,title: _titleController.text, disc: _discController.text)
              .then((value) => {Navigator.pop(context)});
        },
        child: Icon(Icons.done),
      ),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:Hero(tag:'title',child:Text('Edit Note',style: Theme.of(context).textTheme.titleMedium,)) ,),
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
