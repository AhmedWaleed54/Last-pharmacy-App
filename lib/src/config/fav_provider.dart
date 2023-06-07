// import 'package:flutter/material.dart';
// import '../model/favorite.dart';
//
// class FavoritesProvider extends ChangeNotifier {
//   List<Favorite> _favorites = [
//     Favorite(id: 1,name: 'Cerave', image: "assets/cerave.png" ,price: 280, ),
//     Favorite(id: 2,name: 'Vasline',image: "assets/vasline.jpeg" ,price: 50.0, ),];
//
//   List<Favorite> get favorites => _favorites;
//
//   void addFavorite(Favorite favorite) {
//     _favorites.add(favorite);
//     notifyListeners();
//   }
//
//   void removeFavorite(Favorite favorite) {
//     _favorites.remove(favorite);
//     notifyListeners();
//   }
// }