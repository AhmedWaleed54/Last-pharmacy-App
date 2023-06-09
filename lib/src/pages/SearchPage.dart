import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:last_gp/src/pages/product_detail.dart';
import 'dart:convert';
import '../themes/light_color.dart';
import '../themes/theme.dart';

class MedicineSearchPage extends StatefulWidget {
  @override
  _MedicineSearchPageState createState() => _MedicineSearchPageState();
}

class _MedicineSearchPageState extends State<MedicineSearchPage> {
  List<dynamic> searchResults = [];
  final baseUrl = "https://benaahadees.com/mediBookiDashbord/public/api";

  Future<void> searchMedicine(String medName) async {
    // Perform the API request to search for medicine using the name
    final url = Uri.parse('$baseUrl/medicines?lang=en&name=$medName');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        searchResults = data['data'];
      });
      print(data['data']);
      if (searchResults.isEmpty) {
        Fluttertoast.showToast(
          msg: "No medicine is match your query",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          timeInSecForIosWeb: 2,
        );
      }
    } else {
      print('Failed to fetch search results');
    }
  }

  Widget _search() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(200),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                onChanged: (value) {
                  // Call the searchMedicine function whenever the text changes
                  searchMedicine(value);
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 8),
                    prefixIcon: Icon(Icons.search, color: Colors.black87)),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColor.lightBlue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded)),
        centerTitle: true,
        title: const Text('Medicine Search',
          style:TextStyle(fontFamily: "ConcertOne",
          fontWeight: FontWeight.w600,
          fontSize: 25) ,),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            _search(),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final result = searchResults[index];
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(result['name']),
                      subtitle: Text(result['price']),
                      leading: Image.network(result['photo']),
                      onTap: () {
                        // Handle the tap on a search result
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              title: result['name'],
                              imageUrl: result['photo'],
                              price: double.parse(result['price']),
                              description: result['description'],
                              id: result['id'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
