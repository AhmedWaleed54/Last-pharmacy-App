import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart'as http;

import '../themes/light_color.dart';
class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final baseUrl ='http://medibookidashbord.test/api';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    String? token = await storage.read(key: 'Token');
    return token;
  }

  void updatePatientInfo(Map<String, dynamic> formData) async {
    final token = await getToken();
    var Url = '$baseUrl/patient/update/information';

    try {
      var response = await http.post(Uri.parse(Url),
          headers: {
            'Authorization': 'Bearer $token',
            'lang': 'en'
          },
          body: formData);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        print('Patient info updated successfully');
      } else {
        // Handle API errors
        print('Error updating patient info: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors, such as network connectivity issues
      print('Error updating patient info: $e');
    }
  }
  void handleSubmit() {
    // Get the form data and convert it to a map
    Map<String, dynamic> formData = {
      'name': nameController.text,
      'phone': phoneController.text,
      'address' : addressController.text,
    };
    // Call the API function with the form data
    updatePatientInfo(formData);
    Navigator.pushReplacementNamed(context, '/updateSuccess');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { Navigator.pushReplacementNamed(context, '/info'); },),
        backgroundColor: LightColor.lightBlue,
        title: const Text('Update Info',
          style: TextStyle(
            fontFamily: 'PoiretOne',
            fontWeight: FontWeight.bold,
            fontSize: 22
          ),),
        centerTitle: true,
      ),
      body: Center(

        child: Form(
          key: formKey,
          child:Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              elevation: 20.0,
              shadowColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelText: 'Name',
                        hintText: 'Enter the patient\'s name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the patient\'s name';
                        }
                        return null;
                      },
                    ),


                    SizedBox(height: 20,),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelText: 'phone',
                        hintText: 'Enter the patient\'s name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the patient\'s name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height:20,),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(width: 1, color: Colors.blue),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelText: 'address',
                        hintText: 'Enter the patient\'s name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the patient\'s name';
                        }
                        return null;
                      },
                    ),


                    SizedBox(height: 20,),
                    ElevatedButton(
                        onPressed: (){
                               if (formKey.currentState!.validate()) {
                                               handleSubmit();
                                                       }
                               },
                        child: Text('Update'))
                  ],
                ),
              ),
            ),
          ) ,
        ),
      ),
    );
  }
}
