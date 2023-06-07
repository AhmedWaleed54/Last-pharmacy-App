class Favorite {
  int? id;
  String? name;
  String? image;
  double? price;
  String? categoryName;

  Favorite({ required this.id, required this.name, required  this.image, required this.price,required this.categoryName});


   factory Favorite.fromJson(Map<String, dynamic> data) {
    return Favorite(
      id: data['id'],
      name: data['name'],
      price: double.parse(data['price']),
      image: data ['photo'],
      categoryName: data['category']['name'],
      // Parse other properties from JSON as needed
    );
  }
}

