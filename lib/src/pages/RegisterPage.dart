import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'LoginPage.dart';
import 'component_login_Register/background.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterScreen> {
  DateTime? selectedDate;
  String? selectedGender;
  String? selectedBlood;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  Map<String, dynamic> _response = {};

  Future<void> _signup() async {
    final response = await post(
      Uri.parse('http://medibookidashbord.test/api/patient/register'),
      body: {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'phone': _phoneController.text,
        'date_of_birth': selectedDate.toString(),
        'gender': selectedGender,
        'blood_group': selectedBlood,
        'address': _addressController.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Display an Success message
      _response = jsonDecode(response.body);
      Navigator.pushReplacementNamed(context, '/registerSuccess');
    } else {
      // Display an error message
      Fluttertoast.showToast(
        msg: "Register Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
      );
      print("failed");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Background(
          key: null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "REGISTER",
                  style: TextStyle(
                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                width: size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF2661FA)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: "Name"),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android_rounded),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF2661FA)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: "Mobile Number"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home_outlined),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF2661FA)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: "Address"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Color(0xFF2661FA)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today),
                      Text(
                        selectedDate == null
                            ? 'Select Date of Birth'
                            : DateFormat('dd/MM/yyyy').format(selectedDate!),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  width: 150,
                  child: DropdownButtonFormField<String>(
                    value: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                    decoration: InputDecoration(
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF2661FA)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Gender',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text('Female'),
                      ),
                    ],
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a gender';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 13,
                ),
                Container(
                  width: 130,
                  child: DropdownButtonFormField<String>(
                    value: selectedBlood,
                    onChanged: (value) {
                      setState(() {
                        selectedBlood = value;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.bloodtype_rounded),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF2661FA)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Blood-Group',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'o+',
                        child: Text('O+'),
                      ),
                      DropdownMenuItem(
                        value: 'A+',
                        child: Text('A+'),
                      ),
                      DropdownMenuItem(
                        value: 'A-',
                        child: Text('A-'),
                      ),
                      DropdownMenuItem(
                        value: 'B+',
                        child: Text('B+'),
                      ),
                      DropdownMenuItem(
                        value: 'B-',
                        child: Text('B-'),
                      ),
                      DropdownMenuItem(
                        value: 'O-',
                        child: Text('O-'),
                      ),
                      DropdownMenuItem(
                        value: 'AB-',
                        child: Text('AB-'),
                      ),
                      DropdownMenuItem(
                        value: 'AB+',
                        child: Text('AB+'),
                      ),
                    ],
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a blood group';
                      }
                      return null;
                    },
                  ),
                ),
              ]),
              SizedBox(height: 10),
              Container(
                width: size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF2661FA)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: "E-mail"),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_sharp),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF2661FA)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: "Password"),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: size.width,
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'PoiretOne'),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()))
                  },
                  child: Text(
                    "Already Have an Account? Sign in",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
