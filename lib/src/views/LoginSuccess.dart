import 'package:flutter/cupertino.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/mainPage.dart';
class LoginSuccessSplash extends StatelessWidget {
  const LoginSuccessSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:
    Lottie.asset('assets/81243-login-successfully.json'),
    // Container(
    //   margin: EdgeInsets.only(left: 20),
    //   child: Lottie.asset('81243-login-successfully.json'),
    //
    // ),
        backgroundColor: Colors.white10,
        splashIconSize: 400,
        duration: 2000,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        animationDuration: Duration(seconds: 2),

        nextScreen: MainPage(title: 'Home page'));
  }
}
