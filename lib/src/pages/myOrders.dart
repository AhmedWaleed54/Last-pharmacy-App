import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/profileOrders.dart';

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  final baseUrl = 'http://medibookidashbord.test/api';
  final storage =FlutterSecureStorage();
  Future<String?> getToken() async {
    String? token = await storage.read(key: 'Token');
    return token;
  }
  List<Order> orders = [];

  Future<void> fetchOrders() async {
    final url = baseUrl+ '/patient/all/orders';
    final token = await getToken();
    final response = await http.get(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'lang' : 'en'
        }
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var orderList = data['data'] as List<dynamic>;

      setState(() {
        orders = orderList.map((item) => Order(
          id: item['id'],
          date: item['created_at'],
          status: item['shipping_status'],
          paymentMethod: item['status'],
        )).toList();
        print(orderList);
      });
    } else {
      print('Failed to fetch orders');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { Navigator.pushReplacementNamed(context, '/'); }, icon: Icon(Icons.arrow_back_rounded),),
        title: Text('My Orders',
        style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'ConcertOne',
        fontSize: 26),),
        centerTitle: true,
      ),
      body: orders.isEmpty ?Center(
        child: Text('No orders yet',
          style: TextStyle(
            fontFamily: 'ConcertOne',
            fontWeight: FontWeight.bold,
          ),
        )
      )
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            elevation: 8,
            margin: EdgeInsets.all(8),
            shadowColor: Colors.black87,
            child: ListTile(
              title: Text('Order Date: ${order.date}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ order.status == '0' ?
                  Text('Status: prepare') : order.status == '1' ? Text('Status: shipping') : Text('Status: ready')  ,
                  order.paymentMethod == null ?
                  Text('Payment Method: pay on cash') : Text('Payment Method: pay online')
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  order.paymentMethod == null ?
                  FaIcon(FontAwesomeIcons.moneyBill1Wave,size: 30,color: CupertinoColors.systemGreen,) : FaIcon(FontAwesomeIcons.moneyCheckDollar,
                  size: 22,color: CupertinoColors.activeGreen,)
                ],
                
              ),
            ),
          );
        },
      ),
    );
  }
}