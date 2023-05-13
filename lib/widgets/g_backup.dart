// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:note/local_storage/firebase_helper.dart';

import '../constants/strings.dart';
import 'confirmation_dialog.dart';

Widget backup(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
          onTap: () async {
            bool? value = await confirmation(
              title: "NOTE BACKUP",
              context: context,
              content: "",
              cancel: Strings.restore,
              confirm: Strings.backUp,
            );
            if (value != null) {
              FirebaseHelper.signIn(context, value);
            }
          },
          child: getLogo()),
      /*  GestureDetector(
        onTap: () {
                  FirebaseHelper.signOut();
        },
        child: const Icon(Icons.logout),
      ),*/
    ],
  );
}

Widget getLogo() {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  if (googleSignIn.currentUser != null) {
    GoogleSignInAccount? user = googleSignIn.currentUser;
    return CircleAvatar(
      backgroundImage: NetworkImage(user!.photoUrl ?? ""),
    );
  } else {
    return Lottie.asset(
      Strings.googleIcon,
      animate: false,
      height: 50,
      width: 50,
    );
  }
}
