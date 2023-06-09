import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;


class PaymentWebView extends StatefulWidget {
  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  final storage = FlutterSecureStorage();
  var paymentUrl = 'https://www.google.com/';
  final baseurl ='https://benaahadees.com/mediBookiDashbord/public/api';
  late final WebViewController controller;

  Future<String?> getToken() async {
    String? token = await storage.read(key: 'Token');
    return token;
  }

  Future<void> _getWebView() async {
    final token = await getToken();
    final response = await http.post(Uri.parse('$baseurl/patient/payments'),
        headers: {'Authorization': 'Bearer $token'},
        body: {'status': '1'});
        if (response.statusCode == 200) {
    setState(() {
    final _response = json.decode(response.body);
    print(_response);
    // paymentUrl = _response['details']['redirect_url'];
    });
    } else {
    throw Exception('Failed to fetch Medicines');
    }
    }



  @override
  void initState() {
    super.initState();
    _getWebView();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(paymentUrl),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SafeArea(
        child:  ElevatedButton(onPressed: _getWebView, child: Text('data'))
        // WebViewWidget(
        //   controller: controller,

        // ),
      ),
    );
  }
}