import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note/local_storage/local_storage.dart';
import 'package:note/model/note_model.dart';

import '../widgets/toast.dart';

class FirebaseHelper {
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static GoogleSignInAccount? user;
  static GoogleSignInAuthentication? googleAuth;
  static final fireStore = FirebaseFirestore.instance;

  static void signIn() async {
    try {
      if (googleSignIn.currentUser == null) {
        user = await googleSignIn.signIn();
        if (user != null) {
          googleAuth = await user!.authentication;
        }
      } else {
        user = googleSignIn.currentUser;
        googleAuth = await user!.authentication;
      }
    } catch (e) {
      buildToast(text: e.toString());
    }
    if (googleAuth != null) {
      firebaseLogin(googleAuth!);
    }
  }

  static firebaseLogin(GoogleSignInAuthentication account) async {
    final credential = GoogleAuthProvider.credential(
      accessToken: account.accessToken,
      idToken: account.idToken,
    );
    UserCredential cred = await auth.signInWithCredential(credential);
    User? user = cred.user;
    if (user != null) {
      uploadNote(user);
    }
    return;
  }

  static uploadNote(User user) async {
    DBHelper dbHelper = DBHelper();
    List<NoteModel> list = await dbHelper.getAll();
    if (list.isNotEmpty) {
      for (var element in list) {
        fireStore
            .collection(user.email ?? user.uid)
            .doc(element.key)
            .set(element.toJson());
      }
      log("uploaded success");
    }
  }

  static void signOut() async {
    await googleSignIn.signOut();
    buildToast(text: "log out");
  }
}
