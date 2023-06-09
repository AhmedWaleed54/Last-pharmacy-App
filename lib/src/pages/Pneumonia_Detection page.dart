import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  bool isPositive =true;
  File? _image;
  String pnresult = "";
  Future _getImage() async {
    final image = await ImagePicker().getImage(
      source: ImageSource.gallery, // or ImageSource.camera for taking a photo
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future _uploadImage() async {
    if (_image == null) return;

    // Replace 'your-api-endpoint' with the actual API endpoint where you want to send the image
    final url = Uri.parse('https://penumoniadetection.azurewebsites.net/');

    // Create a multipart request for sending the image
    final request = http.MultipartRequest('POST', url);

    // Attach the image file to the request
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

    // Send the request
    final response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      // Image uploaded successfully
      Fluttertoast.showToast(
        msg: "Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );
      dynamic res = await response.stream.bytesToString();
      final result = jsonDecode(res);
      print('Image uploaded!');
      print(result['The prediction is']);
      setState(() {
        pnresult = result['The prediction is'];
        if( result['The prediction is'] == 'Positive'){
          isPositive = true;
        }else {
          isPositive = false;
        }
      });
      
    } else {
      // Error occurred during image upload
      Fluttertoast.showToast(
        msg: "Login Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );
      print('Error uploading image. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!)
                : Icon(Icons.image, size: 100),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Upload Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Send'),
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(pnresult!,
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20,
                    color: isPositive? Colors.red : Colors.green
                  ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
