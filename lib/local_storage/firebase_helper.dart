// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/model/note_model.dart';
import 'package:note/widgets/loading.dart';
import '../widgets/toast.dart';

class FirebaseHelper {
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static GoogleSignInAccount? user;
  static GoogleSignInAuthentication? googleAuth;
  static final fireStore = FirebaseFirestore.instance;
  static final DBHelper dbHelper = DBHelper();

  static void signIn(BuildContext context, bool isRestore) async {
    try {
      if (googleSignIn.currentUser == null) {
        log("user not found for back-up");
        user = await googleSignIn.signIn();
        if (user != null) {
          googleAuth = await user!.authentication;
        }
      } else {
        log("user found for back-up");
        user = googleSignIn.currentUser;
        googleAuth = await user!.authentication;
      }
    } catch (e) {
      log(e.toString());
      buildToast(text: "something went wrong");
    }
    if (googleAuth != null) {
      firebaseLogin(context, googleAuth!, isRestore);
    } else {
      buildToast(text: "something went wrong");
    }
  }

  static void firebaseLogin(BuildContext context,
      GoogleSignInAuthentication account, bool isBackup) async {
    final credential = GoogleAuthProvider.credential(
      accessToken: account.accessToken,
      idToken: account.idToken,
    );
    UserCredential cred = await auth.signInWithCredential(credential);
    User? user = cred.user;
    if (user != null) {
      log("----> $isBackup <---");
      isBackup ? getBackup(context, user) : restoreBackup(context, user);
    } else {
      buildToast(text: "something went wrong");
    }
    return;
  }

  static void getBackup(BuildContext context, User user) async {
    showLoading(show: true, context: context);
    DBHelper dbHelper = DBHelper();
    List<NoteModel> list = await dbHelper.getAll();
    if (list.isNotEmpty) {
      for (var element in list) {
        fireStore
            .collection(user.email ?? user.uid)
            .doc(element.key)
            .set(element.toJson());
      }
      showLoading(show: false, context: context);
      buildToast(text: "back-up successful");
    } else if (list.isEmpty) {
      buildToast(text: "no notes available to backup");
      showLoading(show: false, context: context);
    }
  }

  static void restoreBackup(BuildContext context, User user) async {
    showLoading(show: true, context: context);
    List<NoteModel> notes = <NoteModel>[];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await fireStore.collection(user.email ?? "").get();
    if (snapshot.docs.isNotEmpty) {
      for (var i in snapshot.docs) {
        notes.add(NoteModel.fromJson(i.data()));
        dbHelper.restoreBackup(NoteModel.fromJson(i.data()));
      }
      buildToast(text: "back-up restored successful");
    } else {
      buildToast(text: "data not found");
    }
    showLoading(show: false, context: context);
  }

  static void signOut() async {
    await googleSignIn.signOut();
    buildToast(text: "log out");
  }
}
