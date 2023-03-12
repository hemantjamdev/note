import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note/model/note_model.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class DBHelper {
  Uuid uuid = Uuid();

  Future<void> add({required String title, required String disc}) async {
    final hive = await Hive.openBox<NoteModel>("db");
    final DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('dd/MM//yyyy HH:mm').format(dateTime);
    String key=uuid.v1();
    NoteModel note = NoteModel(key:key,title: title, disc: disc, time: formattedDate);
    hive.put(key,note);
  }

  Future<void> update({required String key,required String title, required String disc}) async{
    final hive = await Hive.openBox<NoteModel>("db");
    final DateTime dateTime = DateTime.now();
   // String key=uuid.v1();
    String formattedDate = DateFormat('dd/MM//yyyy HH:mm').format(dateTime);
    NoteModel note = NoteModel(key:key,title: title, disc: disc, time: formattedDate);
    hive.put(key,note);
  }

  Future<void> delete({required String key}) async{
    final hive = await Hive.openBox<NoteModel>("db");
    hive.delete(key);
  }
}
