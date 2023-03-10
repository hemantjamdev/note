import 'package:flutter/material.dart';
import 'package:note/screens/edit_note.dart';
import 'package:note/screens/home_page.dart';
import 'package:note/screens/splash.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const Splash());
      case "/home":
        return MaterialPageRoute(builder: (context) => const HomePage());
      case "/edit_note":
        return MaterialPageRoute(builder: (context) => const EditNote());
    }
  }
}
