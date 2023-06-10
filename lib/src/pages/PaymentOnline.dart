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
  String? paymentUrl ;
  final baseurl ='https://benaahadees.com/mediBookiDashbord/public/api';
  late final WebViewController controller;

  Future<String?> getToken() async {
    String? token = await storage.read(key: 'Token');
    return token;
  }

  Future<String?> _getWebView() async {
    final token = await getToken();
    final response = await http.post(Uri.parse('$baseurl/patient/payments'),
        headers: {'Authorization': 'Bearer $token'},
        body: {'status': '1'});
    // print(token);
        if (response.statusCode == 200) {
          final _response = json.decode(response.body);
    // setState(() {
    // print(_response);
    // paymentUrl = _response['details']['redirect_url'];
    // print(paymentUrl);
    // });
          print(_response['details']['redirect_url']);
          return _response['details']['redirect_url'];
    } else {
    throw Exception('Failed to fetch Medicines');
    }
    }

  Future<void> _getWeb()  async {
    setState(()  {
      paymentUrl = _getWebView() as String?;
      print(paymentUrl);
    });
  }


  @override
  void initState() {
    super.initState();
    _getWeb();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(paymentUrl!),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SafeArea(
        child: WebViewWidget(
        controller: controller
      )
        // ElevatedButton(
        //   onPressed: () {
        //     WebViewWidget(
        //     controller: controller,
        //
        //   ); },
        //   child: Text(paymentUrl)
        // ),
      ),
    );
  }
}