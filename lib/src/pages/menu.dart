import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../themes/light_color.dart';
import 'LoginPage.dart';

class menuBar extends StatefulWidget {
  @override
  _menuBarState createState() => _menuBarState();
}
class _menuBarState extends State<menuBar>{
  Map<String, dynamic>? patientInfo;
  final baseUrl = 'https://benaahadees.com/mediBookiDashbord/public/api';
  final storage = FlutterSecureStorage();
  Future<String?> getToken() async {
    String? token = await storage.read(key: 'Token');
    return token;
  }

  Future<Map<String, dynamic>> fetchPatientInfo() async {
    final token = await getToken();
    final url = '$baseUrl/patient/information';
    final response = await http.get(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'lang': 'en'
        }
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data['data']);
      return data['data'];
    } else {
      throw Exception('Failed to fetch patient info');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPatientInfo().then((data) {
      setState(() {
        patientInfo = data;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                color: LightColor.lightBlue,
                child:  Center(
                  child: Column(
                        children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(top: 30,bottom: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(image: AssetImage('patient.png'),
                                fit: BoxFit.fill)
                              ),
                            ),
                          Column(
                            children: [
                              patientInfo!= null ? _info() : Text('Wait')
                            ],
                          )
                        ],
                  ),
                ),
              ),
          SizedBox(height: 8,),
          Card(
            elevation: 1.5,
            child: ListTile(
              leading: Icon(Icons.person),
              title: Container(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('profile',
                  style:TextStyle(fontSize: 18,fontFamily: 'ConcertOne',fontWeight: FontWeight.bold),),
              ),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/info');
              },
            ),
          ),
          SizedBox(height: 8,),
          Card(
            elevation: 1.5,
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.cartShopping),
              title: Container(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('Orders',
                  style:TextStyle(fontSize: 18,fontFamily: 'ConcertOne',fontWeight: FontWeight.bold),),
              ),
              onTap:  (){
                Navigator.pushReplacementNamed(context, '/myOrders');
              },
            ),
          ),
          SizedBox(height: 8,),
          Card(
            elevation: 1.5,
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.arrowLeft),
              title: Container(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('Log out',
                  style:TextStyle(fontSize: 18,fontFamily: 'ConcertOne',fontWeight: FontWeight.bold),),
              ),
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          )

        ],

      ),
    );
  }

  Widget _info (){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text( patientInfo?['name'],style: TextStyle(
            fontSize: 25,
            fontFamily: 'ConcertOne',
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),),
        SizedBox(height:9 ,),
        Text(patientInfo?['email'],style: TextStyle(
            fontFamily: 'ConcertOne',
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),)
      ],
    );
  }
}
