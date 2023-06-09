import 'dart:convert';
import 'package:last_gp/src/widgets/extentions.dart';
import '../model/data.dart';
import '../themes/light_color.dart';
import '../themes/theme.dart';
import '../widgets/product_card.dart';
import '../widgets/product_icon.dart';
import '../widgets/title_text.dart';
import 'mainPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'menu.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({ Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isHomePageSelected = true;
  bool isShoppingCartPageSelcted= true;
  Map<String, dynamic> _response = {};
  List<dynamic> _medicines = [];
  Map<String,dynamic> selectedMedicines = {};


  Future<void> _fetchMedicines() async {
    final response = await http.get(Uri.parse('https://benaahadees.com/mediBookiDashbord/public/api/medicines?lang=en'));
    if (response.statusCode == 200) {
      setState(() {
        _response = json.decode(response.body);
        _medicines = _response['data'];

      });
    } else {
      throw Exception('Failed to fetch Medicines');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMedicines();
  }

    // List<ProductCard> productCards = _medicines.map((medicine) {
    //   String title = medicine['name'];
    //   String imageUrl = medicine['photo'];
    //   double price = medicine['price'].toDouble();
    //   return ProductCard(
    //     title: title,
    //     imageUrl: imageUrl,
    //     price: price,
    //   );
    // }).toList();

  Widget _appBar() {
    return Container(
      padding: EdgeInsets.only(top: 0,left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(onPressed: (){
            menuBar;
          }, icon: Icon(Icons.menu_sharp)),
          // ClipRRect(
          //   borderRadius: BorderRadius.all(Radius.circular(13)),
          //   child: Container(
          //     // decoration: BoxDecoration(
          //     //   color: Theme.of(context).backgroundColor,
          //     //   // boxShadow: <BoxShadow>[
          //     //   //   BoxShadow(
          //     //   //       color: Color(0xfff8f8f8),
          //     //   //       blurRadius: 10,
          //     //   //       spreadRadius: 10),
          //     //   // ],
          //     // ),
          //     child: Image.asset("assets/user.png"),
          //   ),
          // ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)))
        ],
      ),
    );

  }
  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: isHomePageSelected ? 'Our' : isShoppingCartPageSelcted? 'Shopping' : "My" ,
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text: isHomePageSelected ? 'Products' :  isShoppingCartPageSelcted? 'Cart' : "Favorites" ,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ));
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppData.categoryList
            .map(
              (category) => ProductIcon(
                model: category,
                onSelected: (model) {
                  setState(() {
                    AppData.categoryList.forEach((item) {
                      item.isSelected = false;
                    });
                    model.isSelected = true;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _productWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullHeight(context),
      child: GridView.count(
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        children: _medicines.map((medicine) {
          int id = medicine['id'];
          String title = medicine['name'];
          String imageUrl = medicine['photo'];
          double price = double.parse(medicine['price']);
          String desc = medicine['description'];
          return ProductCard(
            id : id,
            title: title,
            imageUrl: imageUrl,
            price: price,
            description:desc ,
          );
        }).toList()
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black87)),
              ),
            ),
          ),
          SizedBox(width: 20),
          // _icon(Icons.filter_list, color: Colors.black54)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: LightColor.lightBlue,
      title: Text ('Home page',
        style: TextStyle(
          fontFamily: 'ConcertOne',
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),),
      centerTitle: true,),
      drawer:  menuBar(),
      body: Container(
        height:AppTheme.fullHeight(context)-50, //MediaQuery.of(context).size.height - 210,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // _appBar(),
              _title(),
              _categoryWidget(),
              _productWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
