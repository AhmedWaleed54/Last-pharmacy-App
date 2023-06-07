import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaymentWebView extends StatefulWidget {
  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  final String paymentUrl = 'https://www.google.com.eg/';
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://accept.paymobsolutions.com/api/acceptance/iframes/729770?payment_token=ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SjFjMlZ5WDJsa0lqb3hNVGM0TVRRMExDSmhiVzkxYm5SZlkyVnVkSE1pT2pnek1EQXdMQ0pqZFhKeVpXNWplU0k2SWtWSFVDSXNJbWx1ZEdWbmNtRjBhVzl1WDJsa0lqb3pNemMxTnpZM0xDSnZjbVJsY2w5cFpDSTZNVEkyTlRReU5UazFMQ0ppYVd4c2FXNW5YMlJoZEdFaU9uc2labWx5YzNSZmJtRnRaU0k2SW0xdmFHRnRaV1FpTENKc1lYTjBYMjVoYldVaU9pSmhiR2tpTENKemRISmxaWFFpT2lKT1FTSXNJbUoxYVd4a2FXNW5Jam9pVGtFaUxDSm1iRzl2Y2lJNklrNUJJaXdpWVhCaGNuUnRaVzUwSWpvaVRrRWlMQ0pqYVhSNUlqb2lUa0VpTENKemRHRjBaU0k2SWs1Qklpd2lZMjkxYm5SeWVTSTZJazVCSWl3aVpXMWhhV3dpT2lKdGIyaGhiV1ZrWVd4cFFDNWpiMjBpTENKd2FHOXVaVjl1ZFcxaVpYSWlPaUl3TVRFME5EQXhOakUyTUNJc0luQnZjM1JoYkY5amIyUmxJam9pVGtFaUxDSmxlSFJ5WVY5a1pYTmpjbWx3ZEdsdmJpSTZJazVCSW4wc0lteHZZMnRmYjNKa1pYSmZkMmhsYmw5d1lXbGtJanBtWVd4elpTd2laWGgwY21FaU9udDlMQ0p6YVc1bmJHVmZjR0Y1YldWdWRGOWhkSFJsYlhCMElqcG1ZV3h6WlN3aVpYaHdJam94TmpnMU9ERXhPVFF5TENKd2JXdGZhWEFpT2lJeE5UUXVNVGM1TGpFMU15NHhORE1pZlEuTnYxbWF4RWR6MTctMHV5SUM2Q01EMmNDUDN1c2xjVnhvcVRDMkJqYnIwaEQ2b0p0aURhWEQ0X2ZoWWR0QU1tWXdpaDBTeGlsNEhLaU1mRERjNmI1aUE='),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SafeArea(
        child:  WebViewWidget(
          controller: controller,

        ),
      ),
    );
  }
}