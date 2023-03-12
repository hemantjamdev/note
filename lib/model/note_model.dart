import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String disc;
  @HiveField(3)
  final String time;

  NoteModel({required this.title, required this.disc, required this.time,required this.key});
}
