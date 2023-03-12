import 'package:flutter/material.dart';
import 'package:note/model/note_model.dart';
import 'package:note/screens/edit_note.dart';
import 'package:note/screens/home_page.dart';
import 'package:note/screens/note_add.dart';
import 'package:note/screens/splash.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => Splash());
      case "/home":
        return MaterialPageRoute(builder: (context) => HomePage());
      case "/edit_note":
        return MaterialPageRoute(
            builder: (context) =>
                EditNote(noteModel: settings.arguments as NoteModel));
      case "/add_note":
        return MaterialPageRoute(builder: (context) => AddNote());
      default:
        return MaterialPageRoute(builder: (context) => AddNote());
    }
  }
}
