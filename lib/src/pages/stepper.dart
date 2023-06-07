// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
//
// class test extends StatefulWidget {
//   @override
//   testState createState() => testState();
// }
// class testState extends State<test> {
//   int currentStep =0 ;
//   late ControlsDetails controlsDetails;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order info'),
//       ),
//       body: Theme(
//         data: Theme.of(context).copyWith(
//           colorScheme: ColorScheme.light(primary: LightColor.lightBlue)
//         ),
//         child: Stepper(
//           controlsBuilder:_stepControlsBuilder,
//           steps: getSteps(),
//           type: StepperType.horizontal,
//           currentStep: currentStep,
//           onStepContinue:(){final isLastStep=currentStep==getSteps().length -1;
//             if (isLastStep){
//               print('completed');
//             }else {
//               setState(() {
//                 currentStep+=1;
//               });
//             }
//             },
//           onStepCancel:
//               currentStep ==0 ? null : (){ setState(() =>currentStep-=1);},
//           onStepTapped: (step)=>setState(() {
//             currentStep = step ;
//           }),
//         ),
//       ),
//
//     );
//   }
//
//   List<Step> getSteps() =>
//       [
//         Step(
//             isActive: currentStep >=0 ,
//             state: currentStep > 0 ? StepState.complete : StepState.indexed ,
//             title: Text('Account'),
//             content:Column(
//               children: [
//                 TextFormField(
//                   controller: _fnameController,
//                   decoration: InputDecoration(
//                     labelText: 'First Name',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a name';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _lnameController,
//                   decoration: InputDecoration(
//                     labelText: 'Last name',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a name';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'E-mail',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter an email';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _phoneController,
//                   decoration: InputDecoration(
//                     labelText: 'Phone number',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _phone2Controller,
//                   decoration: InputDecoration(
//                     hintText: 'if you had a second phone number (optional)',
//                   ),
//                 ),
//               ],
//             )
//         ),
//         Step(
//             isActive: currentStep >=1 ,
//             state: currentStep > 1 ? StepState.complete : StepState.indexed ,
//             title: Text('Address'),
//             content:Column(
//               children: [
//                 TextFormField(
//                   controller: _addressController,
//                   decoration: InputDecoration(
//                     labelText: 'Address',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter an address';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _address2Controller,
//                   decoration: InputDecoration(
//                     hintText: 'if you have second address (optional) ',
//                   ),
//                 ),
//                 TextFormField(
//                   controller: _cityController,
//                   decoration: InputDecoration(
//                     labelText: 'City',
//                     icon: Icon(Icons.location_city),
//
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a city';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _stateController,
//                   decoration: InputDecoration(
//                     labelText: 'State',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a state';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _zipController,
//                   decoration: InputDecoration(
//                     labelText: 'Zip code',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter an zip code';
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             )
//         ),
//         Step(
//             isActive: currentStep >=2 ,
//             state: currentStep > 2 ? StepState.complete : StepState.indexed ,
//             title: Text('Complete'),
//             content: Container(
//             )
//         )
//
//       ];
//
//
//   Widget _stepControlsBuilder(BuildContext context, ControlsDetails controlsDetails) {
//     return Container(
//       // Customize the container's content and styling as needed
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//
//           if (controlsDetails.onStepCancel != null)
//             ElevatedButton(
//               onPressed: controlsDetails.onStepCancel,
//               child: Text('Back'),
//             ),
//
//           if (controlsDetails.onStepContinue != null)
//             ElevatedButton(
//               onPressed: controlsDetails.onStepContinue,
//               child: Text('Next'),
//             ),
//         ],
//       ),
//     );
//   }
// }
