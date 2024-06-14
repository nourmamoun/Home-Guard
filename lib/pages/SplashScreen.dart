import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/pages/LoginPage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset("lib/assets/lottie/FL0f78LWB0.json"),
         const Text("Welcome to", style: TextStyle(
          fontFamily: kFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Color(0xff284F99),
         ),),
         const Text("Home Guard", style: TextStyle(
          fontFamily: kFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 32,
          color: Color(kBlueButton)
         ),)
        ],
      ),
      nextScreen: const LoginPage(),
      splashIconSize: 500,
      
      
    );
  }
}
