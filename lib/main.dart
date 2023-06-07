import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:last_gp/src/config/route.dart';
import 'package:last_gp/src/pages/mainPage.dart';
import 'package:last_gp/src/views/newSplashScreen.dart';
import 'package:last_gp/src/widgets/customRoute.dart';

import 'src/themes/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmacy ',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoute(),
      initialRoute:'SplashScreen',
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name!.contains('/detail')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) => MainPage(key: null, title: 'Pharmacy',));
        } else {
          return CustomRoute<bool>(
              builder: (BuildContext context) => NewSplash());
        }
      },
    );
  }
}
