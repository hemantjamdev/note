import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note/constants/colors.dart';
import 'package:note/constants/routes_name.dart';
import 'package:note/constants/strings.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white54,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Lottie.asset(Strings.splash, onLoaded: (onLoaded) {
        Future.delayed(
            const Duration(seconds: 1),
            () => Navigator.pushReplacementNamed(
                context, RoutesName.homepageRoute));
      }),
    );
  }
}
