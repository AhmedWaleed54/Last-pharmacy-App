import 'package:flutter/material.dart';
import 'package:last_gp/src/pages/mainPage.dart';
import '../pages/LoginPage.dart';
import '../pages/SearchPage.dart';
import '../pages/favorite_page.dart';
import '../pages/myOrders.dart';
import '../pages/patientInfo.dart';
import '../pages/product_detail.dart';
import '../pages/shopping_cart_page.dart';
import '../views/LoginSuccess.dart';
import '../views/RegisterSuccess.dart';
import '../views/UpdatedSuccess.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(key: null, title: 'Home page',),
      '/fav': (_) => FavoritePage(),
      '/cart': (_) => ShoppingCartPage(),
      '/info' : (_) => PatientInfoPage(),
      '/login' : (_) => LoginScreen(),
      '/myOrders' : (_) => MyOrderPage(),
      '/loginSuccess' : (_) => LoginSuccessSplash(),
      '/registerSuccess' : (_) => RegisterSuccessSplash(),
      '/updateSuccess' : (_) => UpdatedSuccessSplash (),
      '/search' : (_) => MedicineSearchPage(),
    };
  }
}
