class Order {
   int id;
   String? date;
   String? status;
   String? paymentMethod;

  Order({required this.id, required this.date, required this.status, required this.paymentMethod});
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: json['date'],
      status: json['shipping_status'],
      paymentMethod: json['status'],
    );
  }
}





