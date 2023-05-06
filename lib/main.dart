import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:note/constants/strings.dart';
import 'package:note/model/note_model.dart';
import 'package:note/routes.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'note_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(NoteModelAdapter());
  Hive.openBox<NoteModel>(Strings.databaseName);
  Hive.openBox<String>("titleData");
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const NoteApp()));
}
