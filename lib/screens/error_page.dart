import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note/constants/strings.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Lottie.asset(
          height: MediaQuery.of(context).size.height / 1.1,
          width: MediaQuery.of(context).size.width,
          repeat: false,
          fit: BoxFit.fill,
          Strings.notFound,
        ),
      ),
    );
  }
}
