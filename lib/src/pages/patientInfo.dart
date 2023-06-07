import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../themes/light_color.dart';
import 'UpdatePatientInfo.dart';

class PatientInfoPage extends StatefulWidget {
  @override
  _PatientInfoPageState createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  Map<String, dynamic>? patientInfo;
  final baseUrl = 'http://medibookidashbord.test/api';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_rounded), onPressed: () { Navigator.pushReplacementNamed(context, '/'); },),
        backgroundColor: LightColor.lightBlue,
        title: Text('Patient Info',
        style: TextStyle(
          fontFamily: 'PoiretOne',
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
      ),
      body: Center(
        child: patientInfo != null
            ? _buildPatientInfoCard()
            : CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildPatientInfoCard() {
    return Card(
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient Information',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            _buildFormField('Name', patientInfo!['name']),
            SizedBox(height: 12.0),
            _buildFormField('Email', patientInfo!['email']),
            SizedBox(height: 12.0),
            _buildFormField('Gender', patientInfo!['gender']),
            SizedBox(height: 12.0),
            _buildFormField('Phone', patientInfo!['phone']),
            SizedBox(height: 12.0),
            _buildFormField('Date of birth', patientInfo!['date_of_birth']),
            SizedBox(height: 12.0),
            _buildFormField('Blood_group', patientInfo!['blood_group']),
            SizedBox(height: 12.0),
            _buildFormField('Address', patientInfo!['address']),
            SizedBox(height: 12.0),
            Container(
                margin:EdgeInsets.only(top: 15),
                child: Center(
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile()));
                        },
                        child: Text ('Update',
                        style: TextStyle(fontFamily: 'PoiretOne'),),
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: Colors.black87,
                        backgroundColor: LightColor.lightBlue,
                      ),
                    )
                )
            ),


          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}