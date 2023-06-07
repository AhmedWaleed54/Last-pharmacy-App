// Widget _cartItems() {
//   return Column(children: cart.map((x) => _item(List)).toList());
// }
//
//
// Widget _item(cart) {
//   return Container(
//     height: 80,
//     child: Row(
//       children: <Widget>[
//         AspectRatio(
//           aspectRatio: 1.2,
//           child: Stack(
//             children: <Widget>[
//               Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Container(
//                   height: 70,
//                   width: 70,
//                   child: Stack(
//                     children: <Widget>[
//                       Align(
//                         alignment: Alignment.bottomLeft,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: LightColor.lightGrey,
//                               borderRadius: BorderRadius.circular(10)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: -20,
//                 bottom: -20,
//                 child: Image.asset(
//                   cart['photo'] ?? ' ', width: 80, height: 80,),
//               )
//             ],
//           ),
//         ),
//         Expanded(
//             child: ListTile(
//                 title: TitleText(
//                   text: cart['medicine_name'] ?? '',
//                   fontSize: 15,
//                   fontWeight: FontWeight.w700,
//                 ),
//                 subtitle: Row(
//                   children: <Widget>[
//                     TitleText(
//                       text: '\$ ',
//                       color: LightColor.red,
//                       fontSize: 12,
//                     ),
//                     TitleText(
//                       text: cart['price'].toString(),
//                       fontSize: 14,
//                     ),
//                   ],
//                 ),
//                 trailing: Container(
//                   width: 35,
//                   height: 35,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: LightColor.lightGrey.withAlpha(150),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: TitleText(
//                     text: '${cart['qty']}',
//                     fontSize: 12,
//                   ),
//                 )))
//       ],
//     ),
//   );
// }
//
// Widget _price() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       TitleText(
//         text: '${cart.length} Items',
//         color: LightColor.grey,
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//       ),
//       TitleText(
//         text: '\$${getPrice()}',
//         fontSize: 18,
//       ),
//     ],
//   );
// }
//
// Widget _submitButton(BuildContext context) {
//   return TextButton(
//     onPressed: () {},
//     style: ButtonStyle(
//       shape: MaterialStateProperty.all(
//         RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       ),
//       backgroundColor: MaterialStateProperty.all<Color>(LightColor.lightBlue),
//     ),
//     child: Container(
//       alignment: Alignment.center,
//       padding: EdgeInsets.symmetric(vertical: 4),
//       width: AppTheme.fullWidth(context) * .75,
//       child: TitleText(
//         text: 'Next',
//         color: LightColor.background,
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//   );
// }
//
// double getPrice() {
//   double price = 0;
//   cart.forEach((itm) {
//     price += (itm.price! * itm.quantity!) ?? 0;
//   });
//   return price;
// }
//
//
// @override
// Widget build(BuildContext context) {
//   // return Scaffold(
//   //   appBar: AppBar(
//   //     title: Text('My Cart'),
//   //   ),
//   //   body: cart.isNotEmpty
//   //       ? ListView.builder(
//   //     itemCount: cart.length,
//   //     itemBuilder: (context, index) {
//   //       final item = cart[index];
//   //
//   //       return ListTile(
//   //         // leading: CircleAvatar(
//   //         //   backgroundImage: NetworkImage(item[0]['photo']),
//   //         // ),
//   //         title: Text(item[0]['medicine_name']),
//   //         subtitle: Text('Price: ${item[0]['price']}'),
//   //         trailing: IconButton(
//   //           icon: Icon(Icons.delete),
//   //           onPressed: () {
//   //             // Delete the item from the cart
//   //           },
//   //         ),
//   //       );
//   //     },
//   //   )
//   //       : Center(
//   //     child: CircularProgressIndicator(),
//   //   ),
//   // );
//
//
//   return Container(
//     padding: AppTheme.padding,
//     child: SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           _cartItems(),
//           Divider(
//             thickness: 1,
//             height: 70,
//           ),
//           _price(),
//           SizedBox(height: 30),
//           _submitButton(context),
//
//         ],
//       ),
//     ),
//   );
//
