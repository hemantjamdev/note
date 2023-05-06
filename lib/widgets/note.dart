import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:note/constants/routes_name.dart';
import 'package:note/model/note_model.dart';

import '../utils/date_formate.dart';

Slidable noteWidget(
    {required NoteModel note,
    required BuildContext context,
    required DateTime dateTime,
    required Function handleDelete,
    required Function(String key) handleShare}) {
  DateTime current = DateTime.now();
  String onlyHour = DateFormat("hh:mm").format(dateTime);
  return Slidable(
    endActionPane: ActionPane(
      motion: const DrawerMotion(),
      children: [
        Flexible(
          flex: 1,
          child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.white, width: 3)),
              child: IconButton(
                onPressed:()=> handleDelete(note.key),
                icon: const Icon(Icons.delete, color: Colors.white),
              )),
        ),
        Flexible(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.white, width: 3)),
            child: IconButton(
              onPressed: ()=>handleShare(note.key),
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
    key: Key(note.title),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              NoteModel notes = NoteModel(
                  key: note.key,
                  disc: note.disc,
                  time: note.time,
                  title: note.title);
              Navigator.pushNamed(context, RoutesName.editRoute,
                  arguments: notes);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: Colors.white,
              ),
              child: ListTile(
                title: Text(
                  note.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                subtitle: Text(
                  note.disc,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: Colors.white),
            child: Center(
              child: Text(
                dateTime.day == current.day &&
                        dateTime.year == current.year &&
                        dateTime.month == current.month
                    ? "Today $onlyHour"
                    : formattedDate(dateTime),
                style: const TextStyle(fontSize: 22),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
