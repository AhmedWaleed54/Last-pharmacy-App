
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:last_gp/src/pages/trackOrders.dart';
import '../themes/light_color.dart';
import 'PaymentOnline.dart';
import 'PaymentSuccess.dart';

class meanPayment extends StatefulWidget {
  const meanPayment({Key? key}) : super(key: key);

  _meanPaymentState createState() => _meanPaymentState();
}

class _meanPaymentState extends State<meanPayment> {
  int _selectedOption = 1;
  bool _isSelectedOne =true;
  final storage = FlutterSecureStorage();
  Future<String?> getToken() async {
    String? token = await storage.read(key: 'Token');
    return token;
  }
  void selectPayment () async{
    String baseUrl ='https://benaahadees.com/mediBookiDashbord/public/api/patient/payments';
    final token =await getToken();
    int status = _selectedOption ;
    final url=Uri.parse(baseUrl) ;
    final response =await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token'
        },
        body:
        {
          'status' : '$status'
        }

    );
    if (response.statusCode == 200){
      print('Done');

    }else {

      print('failed ');

    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColor.lightBlue,
        title: Text('Payment'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Card(
              shadowColor: Colors.black87,
              elevation: 10,
              child: RadioListTile(
                title: Text('Pay on Online'),
                value: 1,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {

                    _selectedOption = value!;
                    _isSelectedOne = true;
                  });
                },
                activeColor: Colors.amberAccent, // Customize the selected color
                secondary: Icon(Icons.star), // Add an icon or any other widget
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Card(
              shadowColor: Colors.black87,
              elevation: 10,
              child: RadioListTile(
                title: Text('Pay on cash (delivery)'),
                value: 2,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value!;
                    _isSelectedOne = false;
                  });
                },
                activeColor: Colors.amberAccent, // Customize the selected color
                secondary: Icon(Icons.monetization_on), // Add an icon or any other widget
              ),
            ),
          ),
          // Add more RadioListTile widgets for additional options
          SizedBox(height: 50,),
        ElevatedButton(onPressed:(){

               selectPayment();
               _isSelectedOne ==true?
               Navigator.of(context).pushReplacement(
                 MaterialPageRoute(
                   builder: (BuildContext context) => PaymentWebView())):Navigator.of(context).pushReplacement(
                   MaterialPageRoute(
                       builder: (BuildContext context) => PaymentSuccessPage()
                 ),
               );
         },
            child: Text('Next'),
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            primary: LightColor.lightBlue

          ),




        )
        ],
      ),
    );
  }




}
