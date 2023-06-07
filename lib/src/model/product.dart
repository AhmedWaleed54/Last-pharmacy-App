import 'dart:convert';
import 'dart:core';

class Product {
  int? id;
  String? name;
  String? category;
  String? image;
  int? quantity;
  double?price;
  bool? isliked;
  bool? isSelected;
    Product({this.id,this.name, this.category,this.quantity, this.price, this.isliked,this.isSelected = false,this.image});


}


/*Future<List<dynamic>> fetchData() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data from API');
  }
}*/