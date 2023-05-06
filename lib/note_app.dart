import 'package:flutter/material.dart';
import 'package:note/constants/strings.dart';
import 'package:note/routes.dart';
import 'package:sizer/sizer.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        themeMode: ThemeMode.system,
        title: Strings.title,
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoutes,
      );
    });
  }
}
