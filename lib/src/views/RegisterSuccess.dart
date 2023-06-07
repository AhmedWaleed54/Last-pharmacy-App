import 'package:flutter/cupertino.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/LoginPage.dart';
class RegisterSuccessSplash extends StatelessWidget {
  const RegisterSuccessSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:
    Lottie.asset('104368-thank-you.json'),
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
        nextScreen: LoginScreen(),
    );
  }
}
