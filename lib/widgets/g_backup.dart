import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note/local_storage/firebase_helper.dart';

import '../constants/strings.dart';

Widget backup() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
        onTap: () {
          FirebaseHelper.signIn();
        },
        child: Lottie.asset(

            Strings.googleIcon, animate: false,height: 35,width: 32),
      ), GestureDetector(
        onTap: () {
          FirebaseHelper.signOut();
        },
        child: Icon(Icons.logout),
      ),
    ],
  );
}
