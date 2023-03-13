import 'package:flutter/material.dart';
import 'package:note/constants/strings.dart';
import 'package:note/widgets/delete_all.dart';

AppBar buildAppBar(
    {required BuildContext context,
    required String title,
    bool isHome = false}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Hero(
      tag: Strings.titleHero,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    ),
    centerTitle: true,
    actions: [
      isHome
          ? buildDeleteAll(context: context, text: Strings.allItem)
          : const SizedBox(),
    ],
    // backgroundColor: Colors.blueGrey,
  );
}
