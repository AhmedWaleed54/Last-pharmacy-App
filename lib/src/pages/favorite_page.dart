import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart%20' as http;
import '../model/favorite.dart';
import '../themes/light_color.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final baseUrl = 'http://medibookidashbord.test/api';
  List<Favorite> favoriteMedicines = [];
  final storage =FlutterSecureStorage();
  Future<String?> getToken() async {
    String? token = await storage.read(key: 'Token');
    return token;
  }
  Future<List<Favorite>> getFavoriteMedicines() async {
    final url = 'http://medibookidashbord.test/api/patient/wishlist/medicine?lang=en';
    final token = await getToken();
    final response = await http.get(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      }
    );

    if (response.statusCode == 200) {
      final resData = jsonDecode(response.body);
      final List<dynamic> resList = resData['data'];
      final List<Favorite> favoriteMedicines = [];
      print('getting success');
      for (var item in resList) {
        final medicine = Favorite.fromJson(item);
        favoriteMedicines.add(medicine);
      }
      return favoriteMedicines;
    } else {
      throw Exception('Failed to fetch favorite medicines');
    }
  }
  Future<void> deleteMedicineFromFavorite(int medicineId) async {
    final url = baseUrl + '/patient/wishlist/medicine/$medicineId';
    final token = await getToken();
    final response = await http.delete(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'lang': 'en'
        });

    if (response.statusCode == 200) {
      setState(() {
        favoriteMedicines.removeWhere((favorite) => favorite.id == medicineId);
      });
      Fluttertoast.showToast(
        msg: "Delete from favorite Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,

      );
      // Successful deletion
      print('Medicine deleted from cart successfully!');
    } else {
      Fluttertoast.showToast(
        msg: "Delete from cart Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,

      );
      // Handle the error response
      print('Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getFavoriteMedicines().then((medicines) {
      setState(() {
        favoriteMedicines = medicines;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { Navigator.pushReplacementNamed(context, '/'); }, icon: Icon(Icons.arrow_back_rounded),),
        title: Text('My favorites',
          style: TextStyle(
            fontFamily: 'ConcertOne',
            fontWeight: FontWeight.bold,
            fontSize: 26
          ),),
        centerTitle: true,
        backgroundColor: LightColor.lightBlue,
      ),
      body: favoriteMedicines.isEmpty
          ? Center(
        child: Text('Your Favourite list is empty ',
          style: TextStyle(
            fontFamily: 'ConcertOne',
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),),

      ):
       ListView.builder(
        itemCount: favoriteMedicines.length,
        itemBuilder: (context, index) {
          final fav = favoriteMedicines[index];
          return  Card(
            shadowColor: Colors.black87,
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.network(fav.image!),
              title: Text(
                fav.name!,
                style: TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                'Price: \$${fav.price?.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 14),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Delete the medicine from cart
                      deleteMedicineFromFavorite(fav.id!);
                    },
                  ),
                ],


                // Implement delete logic here

              ),


            ),
          );
        },
      ),
    );
  }
}
