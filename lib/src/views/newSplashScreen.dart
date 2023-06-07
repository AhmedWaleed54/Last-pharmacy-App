import 'package:flutter/cupertino.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/LoginPage.dart';
class NewSplash extends StatelessWidget {
  const NewSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:

    Container(
        margin: EdgeInsets.only(left: 20),
        child: Image.asset('assets/logo.png'),

    ),
        backgroundColor: CupertinoColors.white,
        splashIconSize: 100,
        duration: 2000,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        animationDuration: Duration(seconds: 1),

        nextScreen: LoginScreen());
  }
}
