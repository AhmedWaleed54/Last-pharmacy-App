// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce_app/src/model/orderDetails.dart';
// import 'package:flutter_ecommerce_app/src/model/orderDetails.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import '../model/Orders.dart';
// import '../model/orderDetails.dart';
// import '../model/orderDetails.dart';
// import '../model/orderDetails.dart';
// import '../model/orderDetails.dart';
//
// class OrderTrackPage extends StatefulWidget {
//   _OrderTrackPageState createState() => _OrderTrackPageState();
// }
//  class _OrderTrackPageState extends State<OrderTrackPage> {
//    final storage = FlutterSecureStorage();
//    final baseUrl = 'http://127.0.0.1:8000/api';
//
//    //List<Orders>orders = [];
//    List<dynamic> orders = [];
//    List<dynamic>orderDetails = [];
//
//    // List<orderDetails> orderDetail = [];
//    Future<String?> getToken() async {
//      String? token = await storage.read(key: 'Token');
//      return token;
//    }
//
//    Future<void> getOrder() async {
//      final apiUrl = baseUrl +
//          '/patient/all/orders'; // Replace with your API endpoint URL
//      final token = await getToken();
//      final response = await http.get(Uri.parse(apiUrl),
//          headers: {
//            'Authorization': 'Bearer $token',});
//      if (response.statusCode == 200) {
//        // API call was successful
//        final responseData = jsonDecode(response.body);
//        final List<dynamic> resList = responseData['data'];
//        setState(() {
//          orders = resList;
//        });
//        if (orders.isNotEmpty) {
//          final orderId = orders[0]['id'];
//          print(orders[0]['id']);
//          getOrderDetails(orderId);
//        }
//        // final List<Orders> order = [];
//        // print(resList);
//        // for (var item in resList) {
//        //   final medicine = Orders(
//        //       fname: item['first_name'],
//        //       lname: item['last_name'],
//        //       phone1: int.parse(item['phone1']),
//        //       id:  item['id'],
//        //       address1: item['address1'],
//        //       zipcode: int.parse(item['zip_code']),
//        //       address2: item['address2'],
//        //       phone2: int.parse(item['phone2']),
//        //       city: item['city'],
//        //       state: item['state']
//        //   );
//        //   order.add(medicine);
//        // }
//
//      } else {
//        // API call failed, handle the error
//        throw Exception('failed');
//        print('API request failed with status code: ${response.statusCode}');
//      }
//    }
//
//
//    Future<void> getOrderDetails(int orderId) async {
//      final apiUrl = baseUrl +
//          '/patient/order/detail?id=$orderId&lang=en'; // Replace with your API endpoint URL
//      final token = await getToken();
//      final response = await http.get(Uri.parse(apiUrl),
//          headers: {'Authorization': 'Bearer $token',});
//      if (response.statusCode == 200) {
//        // API call was successful
//        final responseData = jsonDecode(response.body);
//        final List<dynamic> resList = responseData['data'];
//        setState(() {
//          orderDetails = resList[0]['user_medicine_items'];
//        });
//        print(orderDetails);
//        // for (var item in resList) {
//        //   final medicine = orderDetails(
//        //       name: item['user_medicine_items']['medicine_name'],
//        //       orderId: item['id'],
//        //       price: int.parse(item['user_medicine_items']['price']),
//        //       medicineId:  item['user_medicine_items']['id'],
//        //       photo: item['user_medicine_items']['photo'],
//        //       quantity: int.parse(item['user_medicine_items']['qty']),
//        //   );
//        //   orderdetails.add(medicine);
//        // }
//
//      } else {
//        // API call failed, handle the error
//        throw Exception('failed');
//        print('API request failed with status code: ${response.statusCode}');
//      }
//    }
//
//    void initState() {
//      super.initState();
//      getOrder();
//    }
//
//
//    @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//        appBar: AppBar(
//          title: Text('Order Tracking'),
//        ),
//        body: Padding(
//          padding: EdgeInsets.all(16.0),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//              Text(
//                'Order #123456',
//                style: TextStyle(
//                  fontSize: 24.0,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//              SizedBox(height: 16.0),
//              Row(
//                children: [
//                  Expanded(
//                    child: _buildOrderStatusTile(
//                      'Order Placed',
//                      true,
//                    ),
//                  ),
//                  Expanded(
//                    child: _buildOrderStatusTile(
//                      'Shipped',
//                      true,
//                    ),
//                  ),
//                  Expanded(
//                    child: _buildOrderStatusTile(
//                      'Delivered',
//                      false,
//                    ),
//                  ),
//                ],
//              ),
//              SizedBox(height: 16.0),
//              Text(
//                'Order Details',
//                style: TextStyle(
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//              SizedBox(height: 8.0),
//              _buildOrderDetailItem('sd', 2),
//              _buildOrderDetailItem('Item 2', 1),
//              _buildOrderDetailItem('Item 3', 3),
//              SizedBox(height: 8.0),
//
//            ],
//          ),
//        ),
//      );
//    }
//
//    @override
//    Widget _buildOrderStatusTile(String status, bool completed) {
//      return Column(
//        children: [
//          CircleAvatar(
//            backgroundColor: completed ? Colors.green : Colors.grey,
//            radius: 20.0,
//            child: Icon(
//              completed ? Icons.check : Icons.pending,
//              color: Colors.white,
//            ),
//          ),
//          SizedBox(height: 8.0),
//          Text(
//            status,
//            style: TextStyle(
//              fontWeight: FontWeight.bold,
//            ),
//            textAlign: TextAlign.center,
//          ),
//        ],
//      );
//    }
//
//    @override
//    Widget _buildOrderDetailItem(String itemName, int quantity) {
//      return ListTile(
//        leading: CircleAvatar(
//          backgroundColor: Colors.blue,
//          radius: 16.0,
//          child: Text(
//            quantity.toString(),
//            style: TextStyle(
//              color: Colors.white,
//            ),
//          ),
//        ),
//        title: Text(itemName),
//        subtitle: Text('Quantity: $quantity'),
//      );
//    }
//
//  }
//
//

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Order {
   int id;
   String status;

  Order({required this.id, required this.status});
}

class OrderTrackingPage extends StatefulWidget {
  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  List<Order> orders = [];
  Order? selectedOrder;
  bool isLoading = false;
  final baseUrl = 'http://medibookidashbord.test/api';

  final storage = FlutterSecureStorage();
  Future<String?> getToken() async {
     String? token = await storage.read(key: 'Token');
     return token;
   }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    setState(() {
      isLoading = true;
    });

    try {
      final Url = baseUrl +'/patient/all/orders';
      final token = await getToken();
      final response = await http.get(Uri.parse(Url),
          headers: {
            'Authorization': 'Bearer $token'

          });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Order> fetchedOrders = [];
        for (var order in data['data']) {
          fetchedOrders.add(Order(
            id: order['id'],
            status: order['shipping_status'],
          ));
          print(order);
        }
        setState(() {
          orders = fetchedOrders;
          isLoading = true;
        });
      } else {
        throw Exception('Failed to fetch orders');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle error
    }
  }

  Future<void> fetchOrderDetails(Order order) async {
   int id = order.id ;
    setState(() {
      isLoading = true;
    });

    try {
      final Url = baseUrl +'/patient/order/detail?id=$id&lang=en';
      final token = await getToken();
      final response = await http.get(Uri.parse(Url),
          headers: {
            'Authorization': 'Bearer $token'

          });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // order.status = data['shipping_status'];
        print(data);
        setState(() {
          selectedOrder = order;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch order details');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracking'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  final order = orders[index];
                  return ListTile(
                    title: Text('Order ${order.id}'),
                    subtitle: Text(order.status),
                    onTap: () {
                      fetchOrderDetails(order);
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: selectedOrder != null
                  ? OrderDetailsWidget(selectedOrder!)
                  : Center(child: Text('Select an order')),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderDetailsWidget extends StatelessWidget {
  final Order order;

  OrderDetailsWidget(this.order);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Order Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text('Order ID: ${order.id}'),
        SizedBox(height: 10),
        Text('Status: ${order.status}'),
        SizedBox(height: 10),
        // Add more order details as needed
      ],
    );
  }
}
