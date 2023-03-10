import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:note/model/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _add() async {
    final hive = await Hive.openBox<NoteModel>("db");
    NoteModel note = NoteModel(
        disc: "disssssssc", time: DateTime.now(), title: "titleeeeeeeeeeee");
    hive.add(note);

  }

  void _handleDelete() async {
    final hive = Hive.box<NoteModel>("db");
    await hive.clear();
    setState(() {});
  }

  void handAddNote() {}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _add, label: const Text("Add Note")),
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Lottie.asset("assets/animation/sun.json", height: 100),
              Lottie.asset("assets/animation/bird.json", height: 50),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Lottie.asset("assets/animation/chicken.json", height: 100),
                  Lottie.asset("assets/animation/cow.json", height: 85),
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
                  color: Colors.blueGrey,
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
                      valueListenable: Hive.box<NoteModel>("db").listenable(),
                      builder: (context, Box<NoteModel> box, widget) {
                        List<NoteModel> noteList = box.values.toList();
                        return noteList.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: noteList.length,
                                  itemBuilder: (context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigator.pushNamed(context, "/edit_note");
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12),
                                                          topRight:
                                                              Radius.circular(
                                                                  12)),
                                                  color: Colors.white,
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                      "${noteList[index].title}"),
                                                  subtitle: Text(
                                                      "${noteList[index].disc}"),
                                                  trailing: Text(
                                                      "${noteList[index].time}"),
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              GestureDetector(
                                                onTap: _handleDelete,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(18),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    18)),
                                                    color: Colors.white,
                                                  ),
                                                  child:
                                                      const Icon(Icons.delete),
                                                ),
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text("press + to add notes."),
                              );
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
/*

/// shimmeer effect for empty data
Widget showShimmerEffect() {
  return DraggableScrollableSheet(
    initialChildSize: 0.67,
    minChildSize: 0.67,
    builder: (BuildContext context, ScrollController scrollController) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Colors.blueGrey,
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
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: 15,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/edit_note");
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(38.0),
                                child: Center(child: Text("Title $index")),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(18),
                                    bottomRight: Radius.circular(18)),
                                color: Colors.white,
                              ),
                              child: const Icon(Icons.delete),
                            )
                          ],
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
*/
