import 'package:flutter/material.dart';
import 'package:last_gp/src/pages/shopping_cart_page.dart';
import 'package:last_gp/src/widgets/extentions.dart';
import '../../main.dart';
import '../themes/light_color.dart';
import '../themes/theme.dart';
import '../widgets/BottomNavigationBar/bottom_navigation_bar.dart';
import 'SearchPage.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;
  bool isShoppingCartPageSelcted = true;
  bool isSearchPageSelected = true;

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  void onBottomIconPressed(int index) {
    if (index == 0) {
      setState(() {
        isHomePageSelected = true;
        isShoppingCartPageSelcted = false;
        isSearchPageSelected = false;
      });
    } else if (index == 1) {
      setState(() {
        isHomePageSelected = false;
        isShoppingCartPageSelcted = false;
        isSearchPageSelected = true;
      });
    } else if (index == 2) {
      setState(() {
        isHomePageSelected = false;
        isShoppingCartPageSelcted = true;
        isSearchPageSelected = false;
      });
    } else {
      setState(() {
        isHomePageSelected = false;
        isShoppingCartPageSelcted = false;
        isSearchPageSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              height: AppTheme.fullHeight(context) ,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xfffbfbfb),
                    Color(0xfff7f7f7),
                  ],
                  // begin: Alignment.topCenter,
                  // end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          switchInCurve: Curves.easeInToLinear,
                          switchOutCurve: Curves.easeOutBack,
                          child: isHomePageSelected
                              ? MyHomePage(
                                  key: null,
                                  title: 'homePage',
                                )
                              : isShoppingCartPageSelcted
                                  ? Align(
                                      alignment: Alignment.topCenter,
                                      child: ShoppingCartPage(),
                                    )
                                  : isSearchPageSelected
                                      ? Align(
                                          alignment: Alignment.topCenter,
                                          child: MedicineSearchPage())
                                      : Align(
                                          alignment: Alignment.topCenter,
                                          child: FavoritePage(),
                                        )

                          //       ? MyHomePage()
                          //       : Align(
                          //           alignment: Alignment.topCenter,
                          //           child: ShoppingCartPage(),
                          //         ),
                          // ),
                          ))
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(
                onIconPresedCallback: onBottomIconPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
