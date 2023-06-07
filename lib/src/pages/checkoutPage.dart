import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:last_gp/src/pages/product_detail.dart';
import '../model/Cart.dart';
import '../themes/light_color.dart';
import 'PaymentSuccess.dart';
import 'meanOfPayment.dart';
import 'shopping_cart_page.dart';
import 'package:http/http.dart' as http;
class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final storage =FlutterSecureStorage();
  final baseUrl = 'http://127.0.0.1:8000/api';
  List<CartMedicine> orders =[];
  Future<String?> getToken() async {
    String? token = await storage.read(key: 'Token');
    return token;
  }
  Future<List<CartMedicine>> getMedicineOrderFromCart() async {
    final apiUrl = 'http://medibookidashbord.test/api/patient/orders?lang=en';
    final token = await getToken();

    final response = await http.get(Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          });
    if (response.statusCode == 200) {
      // API call was successful
      // You can parse the response body here and handle the data accordingly
      final responseData = jsonDecode(response.body);
      final List<dynamic> resList = responseData['data']['user_cart_items'];
      final List<CartMedicine> med = [];
      print(resList);
      for (var item in resList) {
        final medicine = CartMedicine(
          name: item['medicine_name'],
          price: double.parse(item['price']),
          id:  item['id'],
          image: item['photo'],
          quantity: int.parse(item['qty']),
        );
        med.add(medicine);
      }
      return med;
    } else {
      // API call failed, handle the error
      throw Exception('failed');
      print('API request failed with status code: ${response.statusCode}');
    }
  }
  Future<void> countDownMedicineInCart(int medicineId) async {
    final url = baseUrl +'/patient/orders/$medicineId?lang=en';
    final token = await getToken();
    final response = await http.delete(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'lang': 'en'
        });
    if (response.statusCode == 200) {
      setState(() {
        final updatedMedicine = orders.firstWhere((medicine) => medicine.id == medicineId);
        if (updatedMedicine.quantity != null && updatedMedicine.quantity! > 1)
        {
          updatedMedicine.quantity = updatedMedicine.quantity! - 1;
        }

      });

      print('Medicine quantity updated successfully!');
    } else {
      throw Exception('Failed to update medicine quantity');
    }

  }
  Future<void> deleteMedicineFromCart(int medicineId) async {
    final url = baseUrl + '/patient/orders/$medicineId';
    final token = await getToken();
    final response = await http.delete(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'lang': 'en'
        });

    if (response.statusCode == 200) {
      setState(() {
        orders.removeWhere((order) => order.id == medicineId);
      });

      // Successful deletion
      print('Medicine deleted from cart successfully!');
    } else {
      // Handle the error response
      print('Error: ${response.statusCode}');
    }
  }

  @override

  void initState() {
    super.initState();
    getMedicineOrderFromCart().then((med) {
      setState(() {
        orders = med;
      });
    });
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                  final order = orders[index];
                  bool IsQuantityOne =(order.quantity==1);
                  return Container(
                    height:90,
                    width: 150,
                    child: Card(
                      color: Colors.blueGrey.shade100,
                      shadowColor: Colors.black87,
                      elevation: 10,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: Image.network(order.image!,
                        height: 80,width: 70,),
                        title: Text(
                          order.name!,
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(
                          'Price: \$${order.price?.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: IsQuantityOne ?  null :
                                  ()
                              {
                                // Decrement the medicine quantity
                                countDownMedicineInCart(order.id!);
                              },
                            ),
                            Text(
                              '${order.quantity}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  final ProductDetailsPage details = ProductDetailsPage(title: order.name!, imageUrl: order.image!, price: order.price!, description: 'description', id: order.id!);
                                  details.addToCart();
                                  order.quantity=order.quantity!+1;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Delete the medicine from cart
                                deleteMedicineFromCart(order.id!);
                              },
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                  },
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      ' \$${calculateTotal().toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ScaleTransition(
                scale: _animation,
                child: ElevatedButton(
                  onPressed: () {
                    // Payment processing logic
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Payment Processing'),
                          content: Text('Please wait while we process your payment.'),
                        );
                      },
                    );
                    Future.delayed(Duration(seconds: 3), () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => meanPayment(),
                        ),
                      );
                    });
                  },
                  child: Text('Complete Order'),
                  style: ElevatedButton.styleFrom(
                    primary: LightColor.lightBlue,
                    padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  double calculateTotal() {
    return orders.fold(0, (total, ord) => total + ord.price! * ord.quantity!);
  }
}
