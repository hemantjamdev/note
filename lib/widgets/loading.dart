import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/constants/colors.dart';

showLoading({required bool show, required BuildContext context}) {
  show
      ? showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CupertinoActivityIndicator(
                color: AppColors.white,
                radius: 50,
              ),
            );
          },
          barrierDismissible: false)
      : Navigator.pop(context);
}
