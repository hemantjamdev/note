import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note/constants/routes_name.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, RoutesName.homepageRoute));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Lottie.asset("assets/animation/splash.json"),
    );
  }
}
