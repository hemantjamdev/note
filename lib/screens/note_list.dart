import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note/constants/colors.dart';
import 'package:note/constants/routes_name.dart';
import 'package:note/constants/strings.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/model/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/utils/date_formate.dart';
import 'package:note/widgets/app_bar.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/note.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => NoteListState();
}

class NoteListState extends State<NoteList>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool night = false;
  final dbHelper = DBHelper();

  void handleDelete(String key) {
    dbHelper.delete(key: key);
  }

  void handleShare(String key) async {
    NoteModel? note = await dbHelper.getNoteByKey(key);
    if (note != null) {
      String text =
          "${note.title}\n\n${note.disc}\n\n${formattedDate(note.time)}";
      await Share.share(text);
    }
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    super.initState();
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
      appBar: buildAppBar(
          context: context,
          title: Strings.noteList,
          isHome: true,
          night: night),
      body: Stack(
        children: [
          night
              ? const RiveAnimation.asset(
                  Strings.night,
                  fit: BoxFit.cover,
                )
              : const SizedBox(),
          Lottie.asset(Strings.background, height: 100.h, width: 100.w),
          !night ? Lottie.asset(Strings.bird, height: 200) : const SizedBox(),
          Container(
            alignment: Alignment.bottomCenter,
            height: 32.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !night
                    ? Lottie.asset(Strings.sun, height: 12.h)
                    : Lottie.asset(Strings.moon, height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    !night
                        ? Lottie.asset(Strings.chicken, height: 15.h)
                        : const SizedBox(),
                    !night
                        ? Lottie.asset(Strings.cow, height: 12.h)
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                night
                    ? animationController.forward()
                    : animationController.reverse();
                night = !night;
              });
            },
            child: Lottie.asset(
              fit: BoxFit.fill,
              alignment: Alignment.topLeft,
              onLoaded: (composition) {
                animationController.duration = composition.duration;
              },
              Strings.themeSwitch,
              height: 15.h,
              width: 30.w,
              controller: animationController,
                         ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.67,
            minChildSize: 0.67,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: night ? Colors.white24 : AppColors.black54,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.black,
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
                                    return noteWidget(
                                      note: noteList[index],
                                      context: context,
                                      handleDelete: handleDelete,
                                      handleShare: handleShare,
                                    );
                                  },
                                ),
                              )
                            : const Expanded(
                                child: Center(
                                  child: Text(
                                    Strings.emptyData,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
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
