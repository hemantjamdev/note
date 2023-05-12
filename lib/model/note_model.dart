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
  final DateTime time;

  NoteModel(
      {required this.title,
      required this.disc,
      required this.time,
      required this.key});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      key: json['key'],
      title: json['title'],
      disc: json['disc'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'title': title,
      'disc': disc,
      'time': time.toIso8601String(),
    };
  }
}
