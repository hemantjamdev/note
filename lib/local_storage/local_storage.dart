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
    final hive = await Hive.openBox<String>(Strings.titleDatabaseName);
    hive.put(Strings.titleDatabaseKey, titleName);
  }

  restoreBackup(NoteModel noteModel) async {
    final hive = await Hive.openBox<NoteModel>(Strings.databaseName);
    hive.put(noteModel.key, noteModel);
  }

  add({required String title, required String disc}) async {
    final hive = await Hive.openBox<NoteModel>(Strings.databaseName);
    final DateTime dateTime = DateTime.now();
    String key = uuid.v1();
    NoteModel note =
        NoteModel(key: key, title: title, disc: disc, time: dateTime);
    hive.put(key, note);
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
  }

  void delete({required String key}) async {
    final hive = await Hive.openBox<NoteModel>(Strings.databaseName);
    hive.delete(key);
  }

  void deleteAll() async {
    final hive = await Hive.openBox<NoteModel>(Strings.databaseName);
    hive.clear();
  }

  Future<List<NoteModel>> getAll() async {
    List<NoteModel> notes = <NoteModel>[];
    final hive = await Hive.openBox<NoteModel>(Strings.databaseName);
    notes = hive.values.toList();
    return notes;
  }

  Future<NoteModel?> getNoteByKey(String key) async {
    final hive = await Hive.openBox<NoteModel>(Strings.databaseName);
    return hive.get(key);
  }
}
