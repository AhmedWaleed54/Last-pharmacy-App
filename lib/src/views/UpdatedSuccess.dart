import 'package:flutter/cupertino.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import '../pages/mainPage.dart';
import '../pages/patientInfo.dart';
class UpdatedSuccessSplash extends StatelessWidget {
  const UpdatedSuccessSplash ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:
    Lottie.asset('assets/125891-success-box-blue-and-green-check.json'),
      // Container(
      //   margin: EdgeInsets.only(left: 20),
      //   child: Lottie.asset('81243-login-successfully.json'),
      //
      // ),
      backgroundColor: Colors.white10,
      splashIconSize: 400,
      duration: 1000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: Duration(seconds: 2),
      nextScreen: MainPage(title: 'Home Page',),
    );
  }
}
