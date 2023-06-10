// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce_app/src/model/data.dart';
// import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
// import 'package:flutter_ecommerce_app/src/themes/theme.dart';
// import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
// import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
//
// class ProductDetailPage extends StatefulWidget {
//   ProductDetailPage({ Key? key}) : super(key: key);
//
//   @override
//   _ProductDetailPageState createState() => _ProductDetailPageState();
// }
//
// class _ProductDetailPageState extends State<ProductDetailPage>
//     with TickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<double> animation;
//   @override
//   void initState() {
//     super.initState();
//     controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 300));
//     animation = Tween<double>(begin: 0, end: 1).animate(
//         CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
//     controller.forward();
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   bool isLiked = true;
//   Widget _appBar() {
//     return Container(
//       padding: AppTheme.padding,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           _icon(
//             Icons.arrow_back_ios,
//             color: Colors.black54,
//             size: 15,
//             padding: 12,
//             isOutLine: true,
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           _icon(isLiked ? Icons.favorite : Icons.favorite_border,
//               color: isLiked ? LightColor.red : LightColor.lightGrey,
//               size: 15,
//               padding: 12,
//               isOutLine: false, onPressed: () {
//             setState(() {
//               isLiked = !isLiked;
//             });
//           }),
//         ],
//       ),
//     );
//   }
//
//   Widget _icon(
//     IconData icon, {
//     Color color = LightColor.iconColor,
//     double size = 20,
//     double padding = 10,
//     bool isOutLine = false,
//     Function? onPressed,
//   }) {
//     return Container(
//       height: 40,
//       width: 40,
//       padding: EdgeInsets.all(padding),
//       // margin: EdgeInsets.all(padding),
//       decoration: BoxDecoration(
//         border: Border.all(
//             color: LightColor.iconColor,
//             style: isOutLine ? BorderStyle.solid : BorderStyle.none),
//         borderRadius: BorderRadius.all(Radius.circular(13)),
//         color:
//             isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//               color: Color(0xfff8f8f8),
//               blurRadius: 5,
//               spreadRadius: 10,
//               offset: Offset(5, 5)),
//         ],
//       ),
//       child: Icon(icon, color: color, size: size),
//     ).ripple(() {
//       if (onPressed != null) {
//         onPressed();
//       }
//     }, borderRadius: BorderRadius.all(Radius.circular(13)));
//   }
//
//   Widget _productImage() {
//     return AnimatedBuilder(
//       builder: (context, child) {
//         return AnimatedOpacity(
//           duration: Duration(milliseconds: 500),
//           opacity: animation.value,
//           child: child,
//         );
//       },
//       animation: animation,
//       child: Stack(
//         alignment: Alignment.topCenter,
//         children: <Widget>[
//           TitleText(
//             text: "Skin care",
//             fontSize: 160,
//             color: LightColor.lightGrey,
//           ),
//           Image.asset('assets/cerave.png',
//           width: 500,height: 200,)
//         ],
//       ),
//     );
//   }
//
//   Widget _categoryWidget() {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 0),
//       width: AppTheme.fullWidth(context),
//       height: 80,
//       child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           /*children:
//               AppData.showThumbnailList.map((x) => _thumbnail(x)).toList()),*/
//     ));
//   }
//
//   Widget _thumbnail(String image) {
//     return AnimatedBuilder(
//       animation: animation,
//       //  builder: null,
//       builder: (context, child) => AnimatedOpacity(
//         opacity: animation.value,
//         duration: Duration(milliseconds: 500),
//         child: child,
//       ),
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         child: Container(
//           height: 40,
//           width: 50,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: LightColor.grey,
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(13)),
//             // color: Theme.of(context).backgroundColor,
//           ),
//           child: Image.asset(image),
//         ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13))),
//       ),
//     );
//   }
//
//   Widget _detailWidget() {
//     return DraggableScrollableSheet(
//       maxChildSize: .8,
//       initialChildSize: .53,
//       minChildSize: .53,
//       builder: (context, scrollController) {
//         return Container(
//           padding: AppTheme.padding.copyWith(bottom: 0),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(40),
//                 topRight: Radius.circular(40),
//               ),
//               color: Colors.white),
//           child: SingleChildScrollView(
//             controller: scrollController,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 SizedBox(height: 5),
//                 Container(
//                   alignment: Alignment.center,
//                   child: Container(
//                     width: 50,
//                     height: 5,
//                     decoration: BoxDecoration(
//                         color: LightColor.iconColor,
//                         borderRadius: BorderRadius.all(Radius.circular(10))),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       TitleText(text: "Cerave", fontSize: 25),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: <Widget>[
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               TitleText(
//                                 text: "\$ ",
//                                 fontSize: 18,
//                                 color: LightColor.red,
//                               ),
//                               TitleText(
//                                 text: "280",
//                                 fontSize: 25,
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Icon(Icons.star,
//                                   color: LightColor.yellowColor, size: 17),
//                               Icon(Icons.star,
//                                   color: LightColor.yellowColor, size: 17),
//                               Icon(Icons.star,
//                                   color: LightColor.yellowColor, size: 17),
//                               Icon(Icons.star,
//                                   color: LightColor.yellowColor, size: 17),
//                               Icon(Icons.star_border, size: 17),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//             //    _availableSize(),
//                 SizedBox(
//                   height: 20,
//                 ),
//             //    _availableColor(),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 _description(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _availableSize() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         TitleText(
//           text: "Available Size",
//           fontSize: 14,
//         ),
//         SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             _sizeWidget("US 6"),
//             _sizeWidget("US 7", isSelected: true),
//             _sizeWidget("US 8"),
//             _sizeWidget("US 9"),
//           ],
//         )
//       ],
//     );
//   }
//
//   Widget _sizeWidget(String text, {bool isSelected = false}) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         border: Border.all(
//             color: LightColor.iconColor,
//             style: !isSelected ? BorderStyle.solid : BorderStyle.none),
//         borderRadius: BorderRadius.all(Radius.circular(13)),
//         color:
//             isSelected ? LightColor.orange : Theme.of(context).backgroundColor,
//       ),
//       child: TitleText(
//         text: text,
//         fontSize: 16,
//         color: isSelected ? LightColor.background : LightColor.titleTextColor,
//       ),
//     ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
//   }
//
//   Widget _availableColor() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         TitleText(
//           text: "Available Size",
//           fontSize: 14,
//         ),
//         SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             _colorWidget(LightColor.yellowColor, isSelected: true),
//             SizedBox(
//               width: 30,
//             ),
//             _colorWidget(LightColor.lightBlue),
//             SizedBox(
//               width: 30,
//             ),
//             _colorWidget(LightColor.black),
//             SizedBox(
//               width: 30,
//             ),
//             _colorWidget(LightColor.red),
//             SizedBox(
//               width: 30,
//             ),
//             _colorWidget(LightColor.skyBlue),
//           ],
//         )
//       ],
//     );
//   }
//
//   Widget _colorWidget(Color color, {bool isSelected = false}) {
//     return CircleAvatar(
//       radius: 12,
//       backgroundColor: color.withAlpha(150),
//       child: isSelected
//           ? Icon(
//               Icons.check_circle,
//               color: color,
//               size: 18,
//             )
//           : CircleAvatar(radius: 7, backgroundColor: color),
//     );
//   }
//
//   Widget _description() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         TitleText(
//           text: "Description",
//           fontSize: 15,
//         ),
//         SizedBox(height: 20),
//         Text(AppData.description),
//       ],
//     );
//   }
//
//   FloatingActionButton _flotingButton() {
//     return FloatingActionButton(
//       onPressed: () {},
//       backgroundColor: LightColor.lightBlue,
//       child: Icon(Icons.shopping_basket,
//           color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: _flotingButton(),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//             colors: [
//               Color(0xfffbfbfb),
//               Color(0xfff7f7f7),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           )),
//           child: Stack(
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   _appBar(),
//                   _productImage(),
//                   _categoryWidget(),
//                 ],
//               ),
//               _detailWidget()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
//
// class ProductDetailsPage extends StatelessWidget {
//   final String title;
//   final String imageUrl;
//   final double price;
//
//   ProductDetailsPage({required this.title, required this.imageUrl, required this.price, });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Details'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 200,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(imageUrl),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   '\$${price.toStringAsFixed(2)}',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Product Description:',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec elit placerat, facilisis orci vel, viverra velit. Suspendisse potenti.',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart ' as http;
import 'package:flutter/material.dart';
import '../themes/light_color.dart';

class ProductDetailsPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  final int id;
  ProductDetailsPage(
      {required this.title,
      required this.imageUrl,
      required this.price,
      required this.description,
      required this.id});
  final storage = FlutterSecureStorage();
  bool isFav = false;
  Future<String?> getToken() async {
    String? token = await storage.read(key: 'Token');
    return token;
  }

  void addToCart() async {
    String baseUrl = 'https://benaahadees.com/mediBookiDashbord/public/api/patient/orders/';
    int medicineId = id;
    final token = await getToken();
    final url = Uri.parse(baseUrl + '$medicineId');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      // Successful request
      Fluttertoast.showToast(
        msg: "Added to cart Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
      );
      final res = jsonDecode(response.body);
      print(res);
      print('Medicine added to cart successfully!');
    } else {
      // Handle the error response
      Fluttertoast.showToast(
        msg: "Added to cart Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
      );
      print('Error: ${response.statusCode}');
    }
  }

  void addToFavorites() async {
    String baseUrl =
        'https://benaahadees.com/mediBookiDashbord/public/api/patient/wishlist/medicine';
    final token = await getToken();
    int medicineId = id;
    final url = Uri.parse(baseUrl);
    final response = await http.post(url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'medicine_id': '$medicineId'});
    if (response.statusCode == 200) {
      print('add to wishlist success');
      Fluttertoast.showToast(
        msg: "Added to favorite Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Added to favorite Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
      );
      print('failed adding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColor.lightBlue,
        centerTitle: true,
        title: const Text(
          'Product Details',
          style: TextStyle(
              fontFamily: 'ConcertOne',
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: LightColor.lightBlue,
                      ),
                    ),
                    SizedBox(width: 200),
                    IconButton(
                      icon: Icon(Icons.favorite
                        // isFav ? Icons.favorite : Icons.favorite_border,
                        // color: isFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        // Toggle the favorite state

                        addToFavorites();
                        // Perform additional actions like adding/removing from favorites

                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Product Description:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: FloatingActionButton(
              onPressed: () {
                addToCart();
              },
              backgroundColor: LightColor.lightBlue,
              child: Icon(Icons.shopping_basket,
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}
