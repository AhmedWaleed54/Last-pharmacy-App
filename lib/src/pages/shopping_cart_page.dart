import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_gp/src/pages/store%20info%20order.dart';
import '../model/Cart.dart';
import '../themes/light_color.dart';
import 'product_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final String baseUrl = 'https://benaahadees.com/mediBookiDashbord/public/api';
  final storage = FlutterSecureStorage();

  Future<void> countDownMedicineInCart(int medicineId) async {
    final url = baseUrl + '/patient/orders/$medicineId?lang=en';
    final token = await getToken();
    final response = await http.delete(Uri.parse(url),
        headers: {'Authorization': 'Bearer $token', 'lang': 'en'});
    if (response.statusCode == 200) {
      setState(() {
        final updatedMedicine =
            cart.firstWhere((medicine) => medicine.id == medicineId);
        if (updatedMedicine.quantity != null && updatedMedicine.quantity! > 1) {
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
        headers: {'Authorization': 'Bearer $token', 'lang': 'en'});

    if (response.statusCode == 200) {
      setState(() {
        cart.removeWhere((medicine) => medicine.id == medicineId);
      });
      Fluttertoast.showToast(
        msg: "Delete from cart Successfully",
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

  Future<String?> getToken() async {
    String? token = await storage.read(key: 'Token');
    return token;
  }

  List<CartMedicine> cart = [];
  Future<List<CartMedicine>> getMedicineFromCart() async {
    final apiUrl =
        'https://benaahadees.com/mediBookiDashbord/public/api/patient/orders?lang=en'; // Replace with your API endpoint URL
    final token = await getToken();

    final response = await http.get(Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token', 'lang': 'en'});
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
          id: item['id'],
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

  void initState() {
    super.initState();
    getMedicineFromCart().then((med) {
      setState(() {
        cart = med;
      });
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: ListView.builder(
  //       itemCount: cart.length,
  //       itemBuilder: (context, index) {
  //         final medicine = cart[index];
  //         return ListTile(
  //           title: Text(medicine.name!),
  //           subtitle: Text('Price: \$${medicine.price?.toStringAsFixed(2)}'),
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'My cart',
          style: TextStyle(
              fontFamily: 'ConcertOne',
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor: LightColor.lightBlue,
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'ConcertOne',
                    fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final medicine = cart[index];
                bool IsQuantityOne = (medicine.quantity == 1);
                return Card(
                  shadowColor: Colors.black87,
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.network(medicine.image!),
                    title: Text(
                      medicine.name!,
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      'Price: \$${medicine.price?.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: IsQuantityOne
                              ? null
                              : () {
                                  // Decrement the medicine quantity
                                  countDownMedicineInCart(medicine.id!);
                                },
                        ),
                        Text(
                          '${medicine.quantity}',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              final ProductDetailsPage details =
                                  ProductDetailsPage(
                                      title: medicine.name!,
                                      imageUrl: medicine.image!,
                                      price: medicine.price!,
                                      description: 'description',
                                      id: medicine.id!);
                              details.addToCart();
                              medicine.quantity = medicine.quantity! + 1;
                            });

                            // Increment the medicine quantity
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Delete the medicine from cart
                            deleteMedicineFromCart(medicine.id!);
                          },
                        ),
                      ], // Implement delete logic here
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: EdgeInsets.only(bottom: 55),
                height: 60,
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total: \$${calculateTotal().toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: LightColor.lightBlue),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientInformationForm(),
                            ));
                        // Implement checkout logic here
                      },
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          fontFamily: 'ConcertOne',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  double calculateTotal() {
    return cart.fold(
        0, (total, medicine) => total + medicine.price! * medicine.quantity!);
  }
}
