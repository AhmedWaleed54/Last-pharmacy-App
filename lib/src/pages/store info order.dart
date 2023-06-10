import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_gp/src/pages/shopping_cart_page.dart';
import '../themes/light_color.dart';
import 'PaymentSuccess.dart';
import 'checkoutPage.dart';


class PatientInformationForm extends StatefulWidget {
  @override
  _PatientInformationFormState createState() => _PatientInformationFormState();
}

class _PatientInformationFormState extends State<PatientInformationForm> {
  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  int currentStep = 0;
  bool  isCompeletd =false;
  final storage = FlutterSecureStorage();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _phone2Controller = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  double? totalPrice = Value.getString();

  Future<String?> getToken() async {
    String? token = await storage.read(key: 'Token');
    return token;
  }


  Future<void> storePatientInformationOrder(Map<String, dynamic> orderData) async {
    final url = 'https://benaahadees.com/mediBookiDashbord/public/api/patient/orders?lang=en';
    final token = await getToken();
    final response = await http.post(
      Uri.parse(url),
      body: orderData,
      headers: {
        'Authorization': 'Bearer $token',
         'lang' : 'en'
       },
    );
    if (response.statusCode == 200) {
      print('Patient information order stored successfully!');

    } else {
      throw Exception('Failed to store patient information order');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColor.lightBlue,
        title: Text('Order info'),
      ),
      body:
        Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: LightColor.lightBlue)
        ),
        child: Stepper(

           controlsBuilder: _stepControlsBuilder,
          steps: getSteps(),
          type: StepperType.horizontal,
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              print('completed');

                if (_formKeys[currentStep].currentState!.validate()) {
                  // Form is valid, create the order data and send to API
                  final orderData = {
                    'first_name': _fnameController.text,
                    'last_name': _lnameController.text,
                    'email': _emailController.text,
                    'phone1': _phoneController.text,
                    'phone2': _phone2Controller.text,
                    'address1': _addressController.text,
                    'address2': _address2Controller.text,
                    'city': _cityController.text,
                    'state': _stateController.text,
                    'zip_code': _zipController.text,
                    'total' :  totalPrice.toString()
                  };

                  storePatientInformationOrder(orderData)
                      .then((_) {
                    // Order stored successfully, navigate to creative page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(),
                      ),
                    );
                  })
                      .catchError((error) {
                    print('Error: $error');
                    // Handle error if needed
                  });
                }



            } else {
              setState(() {
                currentStep += 1;
              });
            }
          },
          onStepCancel:
          currentStep == 0 ? null : () {
            setState(() => currentStep -= 1);
          },
          onStepTapped: (step) =>
              setState(() {
                currentStep = step;
              }),
        ),
      ),

    );
  }

  List<Step> getSteps() =>
      [
        Step(
            isActive: currentStep >= 0,
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: Text('Account'),
            content:
              Form(
                key: _formKeys[0],
                child: Column(
                  children: [
                    TextFormField(
                      controller: _fnameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: LightColor.lightBlue),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        labelText: 'First Name',
                        icon: Icon(Icons.person)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height:  16,),
                    TextFormField(
                      controller: _lnameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Last name',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: LightColor.lightBlue),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          icon: Icon(Icons.person)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height:  16,),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: LightColor.lightBlue),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          icon: Icon(Icons.email)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height:  16,),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: LightColor.lightBlue),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        labelText: 'Phone number',
                          icon: Icon(Icons.phone)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height:  16,),
                    TextFormField(
                      controller: _phone2Controller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 1, color: LightColor.lightBlue),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: 'if you had a second phone number (optional)',
                      ),
                    ),
                  ],
                ),
              ),
            )
        ,

        Step(
            isActive: currentStep >= 1,
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            title: Text('Address'),
            content:  Form(
              key: _formKeys[1],
              child: Column(
                  children: [
                    TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: LightColor.lightBlue),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        labelText: 'Address',
                          icon: Icon(Icons.home)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height:  16,),
                    TextFormField(
                      controller: _address2Controller,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: LightColor.lightBlue),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        hintText: 'if you have second address (optional) ',
                          icon: Icon(Icons.home)
                      ),
                    ),
                    SizedBox(height:  16,),
                    TextFormField(
                      controller: _cityController,
                      keyboardType:TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'City',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 1, color: LightColor.lightBlue),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        icon: Icon(Icons.location_city),

                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a city';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height:  16,),
                    TextFormField(
                      controller: _stateController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'State',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: LightColor.lightBlue),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          icon: Icon(Icons.other_houses_rounded)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a state';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height:  16,),
                    TextFormField(
                      controller: _zipController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Zip code',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: LightColor.lightBlue),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          icon: Icon(Icons.qr_code_sharp)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an zip code';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
            ),
            )
        ,
        Step(
            isActive: currentStep >= 2,
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            title: Text('Complete'),
            content: Form(
                key:_formKeys[2] ,
                child: Container(
                  padding: EdgeInsets.only(top:250),

                )
            )
        )

      ];


  Widget _stepControlsBuilder(BuildContext context,
      ControlsDetails controlsDetails) {
    return Container(
      // Customize the container's content and styling as needed
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (controlsDetails.onStepCancel != null)
              ElevatedButton(
                onPressed: controlsDetails.onStepCancel,
                child: Text('Back'),
              ),

            if (controlsDetails.onStepContinue != null)
              ElevatedButton(
                onPressed: controlsDetails.onStepContinue,
                child: Text('Next'),

              ),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _zipController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Patient Information'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//           TextFormField(
//                           controller: _fnameController,
//                           keyboardType: TextInputType.text,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'First Name',
//                             icon: Icon(Icons.person)
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please enter a name';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height:  16,),
//             TextFormField(
//                             controller: _lnameController,
//                             keyboardType: TextInputType.text,
//                             decoration: InputDecoration(
//                               labelText: 'Last name',
//                               border: OutlineInputBorder(),
//                                 icon: Icon(Icons.person)
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter a name';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height:  16,),
//                           TextFormField(
//                             controller: _emailController,
//                             keyboardType: TextInputType.emailAddress,
//                             decoration: InputDecoration(
//                               labelText: 'E-mail',
//                               border: OutlineInputBorder(),
//                                 icon: Icon(Icons.email)
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter an email';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height:  16,),
//                           TextFormField(
//                             controller: _phoneController,
//                             keyboardType: TextInputType.phone,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Phone number',
//                                 icon: Icon(Icons.phone)
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter a phone number';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height:  16,),
//         TextFormField(
//                           controller: _phone2Controller,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             icon: Icon(Icons.phone),
//                             border: OutlineInputBorder(),
//                             hintText: 'if you had a second phone number (optional)',
//                           ),
//                         ),
//         TextFormField(
//                           controller: _addressController,
//                           keyboardType: TextInputType.streetAddress,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Address',
//                               icon: Icon(Icons.home)
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please enter an address';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height:  16,),
//                         TextFormField(
//                           controller: _address2Controller,
//                           keyboardType: TextInputType.streetAddress,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: 'if you have second address (optional) ',
//                               icon: Icon(Icons.home)
//                           ),
//                         ),
//                         SizedBox(height:  16,),
//                         TextFormField(
//                           controller: _cityController,
//                           keyboardType:TextInputType.text,
//                           decoration: InputDecoration(
//                             labelText: 'City',
//                             border: OutlineInputBorder(),
//                             icon: Icon(Icons.location_city),
//
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please enter a city';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height:  16,),
//                         TextFormField(
//                           controller: _stateController,
//                           keyboardType: TextInputType.text,
//                           decoration: InputDecoration(
//                             labelText: 'State',
//                             border: OutlineInputBorder(),
//                               icon: Icon(Icons.other_houses_rounded)
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please enter a state';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height:  16,),
//                         TextFormField(
//                           controller: _zipController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             labelText: 'Zip code',
//                             border: OutlineInputBorder(),
//                               icon: Icon(Icons.qr_code_sharp)
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please enter an zip code';
//                             }
//                             return null;
//                           },
//                         ),
//             ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   // Form is valid, create the order data and send to API
//                   final orderData = {
//                     'first_name': _fnameController.text,
//                     'last_name': _lnameController.text,
//                     'email': _emailController.text,
//                     'phone1': _phoneController.text,
//                     'phone2': _phone2Controller.text,
//                     'address1': _addressController.text,
//                     'address2': _address2Controller.text,
//                     'city': _cityController.text,
//                     'state': _stateController.text,
//                     'zip_code': _zipController.text,
//                   };
//                   storePatientInformationOrder(orderData)
//                       .then((_) {
//                     // Order stored successfully, navigate to creative page
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PaymentSuccessPage(),
//                       ),
//                     );
//                   })
//                       .catchError((error) {
//                     print('Error: $error');
//                     // Handle error if needed
//                   });
//                 }
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
// void dispose() {
//   _fnameController.dispose();
//   _lnameController.dispose();
//   _zipController.dispose();
//   _stateController.dispose();
//   _cityController.dispose();
//   _addressController.dispose();
//   _phoneController.dispose();
//   _emailController.dispose();
//   super.dispose();
// }
}



