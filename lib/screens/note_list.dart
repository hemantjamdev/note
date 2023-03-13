import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:note/constants/routes_name.dart';
import 'package:note/constants/strings.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/model/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/widgets/app_bar.dart';
import 'package:note/widgets/confirmation_dialog.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final dbHelper = DBHelper();

  void _handleDelete(
      {required BuildContext context, required String key}) async {
    await confirmation(context: context, text: Strings.thisItem).then((value) {
      if (value) {
        dbHelper.delete(key: key);
      }
    });
  }

  String getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "th";
    }
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          heroTag: Strings.fabHero,
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.noteAddRoute);
          },
          label: const Text(Strings.add)),
      appBar:
          buildAppBar(context: context, title: Strings.noteList, isHome: true),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Lottie.asset(Strings.sun, height: 100),
              Lottie.asset(Strings.bird, height: 50),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Lottie.asset(Strings.chicken, height: 100, repeat: false),
                  Lottie.asset(Strings.cow, height: 85),
                ],
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.67,
            minChildSize: 0.67,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.black54,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ValueListenableBuilder(
                      valueListenable: Hive.box<NoteModel>(Strings.databaseName)
                          .listenable(),
                      builder: (context, Box<NoteModel> box, widget) {
                        List<NoteModel> noteList = box.values.toList();
                        return noteList.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: noteList.length,
                                  itemBuilder: (context, int index) {
                                    DateTime dateTime = noteList[index].time;
                                    DateTime current = DateTime.now();
                                    String onlyHour = DateFormat("hh:mm")
                                        .format(noteList[index].time);

                                    String formattedDate = DateFormat(
                                            "dd'${getOrdinalSuffix(dateTime.day)}' MMM yy  hh:mm")
                                        .format(dateTime);

                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          GestureDetector(
                                            onTap: () {
                                              NoteModel notes = NoteModel(
                                                  key: noteList[index].key,
                                                  disc: noteList[index].disc,
                                                  time: noteList[index].time,
                                                  title: noteList[index].title);
                                              Navigator.pushNamed(
                                                  context, RoutesName.editRoute,
                                                  arguments: notes);
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  noteList[index].title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                subtitle: Text(
                                                  noteList[index].disc,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                trailing: Text(
                                                  dateTime.day == current.day &&
                                                          dateTime.year ==
                                                              current.year &&
                                                          dateTime.month ==
                                                              current.month
                                                      ? "Today $onlyHour"
                                                      : formattedDate,
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          GestureDetector(
                                              onTap: () {
                                                _handleDelete(
                                                    context: context,
                                                    key: noteList[index].key);
                                              },
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(12),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                      color: Colors.white),
                                                  child:
                                                      const Icon(Icons.delete)))
                                        ]));
                                  },
                                ),
                              )
                            : const Expanded(
                                child: Center(
                                    child: Text(
                                Strings.emptyData,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )));
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
