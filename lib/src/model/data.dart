
import 'package:last_gp/src/model/category.dart';
import 'package:last_gp/src/model/product.dart';


class AppData {
  static List<Product> productList = [
    Product(
        id: 1,
        name: 'Cerave',
        price: 280.00,
        isSelected: true,
        isliked: false,
        image: 'assets/cerave.png',
        category: "Skin care"),
    Product(
        id: 2,
        name: 'Vasline',
        price: 50,
        isliked: false,
        image: 'assets/vasline.jpeg',
        category: "Skin care")
    ,
  ];
  // static List<Cart> cartList = [
  //   Cart(
  //       id: 1,
  //       name: 'Cerave',
  //       price: 280.00,
  //       quantity: 1,
  //       image: 'assets/Cerave.png',
  //       category: "Skin care"),
  //   Cart(
  //       id: 2,
  //       name: 'Vasline',
  //       price: 50.00,
  //       image: 'assets/vasline.jpeg',
  //       quantity: 5,
  //       category: "Skin care"),
    /*Product(
        id: 1,
        name: 'Nike Air Max 92607',
        price: 220.00,
        isliked: false,
        image: 'assets/small_tilt_shoe_3.png',
        category: "Trending Now"),
    Product(
        id: 2,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/small_tilt_shoe_1.png',
        category: "Trending Now"),*/
    // Product(
    //     id:1,
    //     name: 'Nike Air Max 97',
    //     price: 190.00,
    //     isliked: false,
    //     image: 'assets/small_tilt_shoe_2.png',
    //     category: "Trending Now"),

  static List<Category> categoryList = [
    Category(),
    Category(
        id: 1,
        name: "Oinment",
        image: 'assets/oinment.jpeg',
        isSelected: true),
    Category(id: 2, name: "pills", image: 'assets/pill.png'),

  ];
 /* static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.png",
    "assets/shoe_thumb_1.png",
    "assets/shoe_thumb_4.png",
    "assets/shoe_thumb_3.png",
  ];*/
  static String description =
      "This medication is used as a moisturizer to treat or prevent dry, rough, scaly, itchy skin and minor skin irritations (such as diaper rash, skin burns from radiation therapy). Emollients are substances that soften and moisturize the skin and decrease itching and flaking. Some products (such as zinc oxide, white petrolatum) are used mostly to protect the skin against irritation (such as from wetness).Dry skin is caused by a loss of water in the upper layer of the skin. Emollients/moisturizers work by forming an oily layer on the top of the skin that traps water in the skin. Petrolatum, lanolin, mineral oil and dimethicone are common emollients. Humectants, including glycerin, lecithin, and propylene glycol, draw water into the outer layer of skin. Many products also have ingredients that soften the horny substance (keratin) that holds the top layer of skin cells together (including urea, alpha hydroxy acids such as lactic/citric/glycolic acid, and allantoin). This helps the dead skin cells fall off, helps the skin keep in more water, and leaves the skin feeling smoother and softer.";
}


/*1. Add the http package as a dependency in your pubspec.yaml file:
dependencies:
http: ^0.13.4

2. Import the http package in your Dart file:
import 'package:http/http.dart' as http;

3. Make an HTTP request using the http.get() or http.post() methods. For example, to make a GET request to an API, you can use:
var response = await http.get(Uri.parse('https://api.example.com/data'));


Future<void> fetchData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}



Future<List<dynamic>> fetchData() async {
  final response = await http.get(Uri.parse('http://localhost:3000/my-api'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data from API');
  }
}


Use the http.post() function to make a POST request:

Future<void> sendData() async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'title': 'foo',
      'body': 'bar',
      'userId': 1,
    }),
  );
  if (response.statusCode == 201) {
    print(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}


Note that you need to import the dart:convert library to use jsonEncode() and convert a Map to a JSON string.



4. Parse the response data. Depending on the API, the response data can be in different formats such as JSON or XML. You can use a package like dart:convert to convert the response data into a Dart object. For example, to parse a JSON response:
import 'dart:convert';

var jsonResponse = jsonDecode(response.body);





5. Use the parsed data in your Flutter app. You can display the data in widgets or use it to perform other tasks.
Note that some APIs may require authentication or API keys. In this case, you will need to include the required authentication or API key in the HTTP request headers or as a query parameter.*/
