class orderDetails {

  int? orderId;
  int? medicineId;
  String? name;
  String? photo;
  int? quantity;
  int? price;


  orderDetails({this.orderId,this.name, this.medicineId,this.quantity, this.photo,this.price,});
  orderDetails.fromJson({required Map <String,dynamic> data})
  {
    orderId = data['id'];
    name = data['user_medicine_items']['medicine_name'].toString();
    photo = data['user_medicine_items']['photo'].toString();
    price =  int.parse(data['user_medicine_items']['price']);
    quantity =int.parse(data ['user_medicine_items']['qty']);
    medicineId =data ['user_medicine_items']['id'];

  }




}