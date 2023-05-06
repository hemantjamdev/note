import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:note/constants/strings.dart';
import 'package:note/model/note_model.dart';
import 'package:uuid/uuid.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() {
    return _instance;
  }

  DBHelper._internal();

  Uuid uuid = const Uuid();

  saveTitle(String titleName) async {
    final hive = await Hive.openBox<String>("titleData");
    final DateTime dateTime = DateTime.now();
    hive.put("title", titleName);
    log("title saved");
  }

  add({required String title, required String disc}) async {
    final hive = await Hive.openBox<NoteModel>(Strings.databaseName);
    final DateTime dateTime = DateTime.now();
    String key = uuid.v1();
    NoteModel note =
        NoteModel(key: key, title: title, disc: disc, time: dateTime);
    hive.put(key, note);
    log("note added");
  }

  update(
      {required String key,
      required String title,
      required String disc}) async {
    final hive = await Hive.openBox<NoteModel>(Strings.databaseName);
    final DateTime dateTime = DateTime.now();
    NoteModel note =
        NoteModel(key: key, title: title, disc: disc, time: dateTime);
    hive.put(key, note);
    log("title updated");
  }

  void delete({required String key}) async {
    final hive = await Hive.openBox<NoteModel>(Strings.databaseName);
    hive.delete(key);
    log("title deleted");
  }

  void deleteAll() async {
    final hive = await Hive.openBox<NoteModel>(Strings.databaseName);
    hive.clear();
    log("deleted all");
  }

  Future<NoteModel?> getNoteByKey(String key) async {
    final hive = await Hive.openBox<NoteModel>(Strings.databaseName);
    return hive.get(key);
  }
}
