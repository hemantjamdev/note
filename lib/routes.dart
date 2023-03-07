import 'package:flutter/material.dart';
import 'package:note/screens/home_page.dart';
import 'package:note/screens/splash.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => Splash());
      case "/home":
        return MaterialPageRoute(builder: (context) => HomePage());
      case "/edit_note":
        return MaterialPageRoute(builder: (context) => HomePage());
    }
  }
}
