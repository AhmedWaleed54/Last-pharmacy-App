class CartMedicine {

  int? id;
  String? name;
  String? category;
  String? image;
  int? quantity;
  double? price;

  CartMedicine({this.id,this.name, this.category,this.quantity, this.price,this.image});
  CartMedicine.fromJson({required Map <String,dynamic> data})
  {
    id = data['id'];
    name = data['medicine_name'].toString();
    price =  double.parse(data['price']);
    image = data ['image'];
    quantity =int.parse(data ['qty']);

  }




}