import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'services.dart';
import 'api.dart';

class addservice extends StatefulWidget {
  final int vId;

  addservice({required this.vId});
  @override
  _addserviceState createState() => _addserviceState();
}

class _addserviceState extends State<addservice> {
  File? image;
  TextEditingController Service_name = TextEditingController();
  TextEditingController Service_category = TextEditingController();
  TextEditingController Service_price = TextEditingController();
  bool isChecked = false;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadService() async {
    if (Service_name.text.isEmpty ||
        Service_category.text.isEmpty ||
        Service_price.text.isEmpty ||
        image == null) {
      // Handle case where any of the fields is empty
      return;
    }

    // Convert image to base64
    List<int> imageBytes = await image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    // Create a JSON payload
    Map<String, dynamic> data = {
      'vId': widget.vId,
      'Service_name': Service_name.text,
      's_description': Service_category.text,
      'Service_price': Service_price.text,
      'image': base64Image,
      'isChecked':isChecked,
    };

    // Send data to PHP server
    var url = Uri.parse(apiUrl+'addservice.php');
    var response = await http.post(url, body: jsonEncode(data));

    if (response.statusCode == 200) {
      // Service added successfully
      print('Service added successfully');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServicesPage(
            vId: widget.vId,
          ),
        ),
      );
    } else {
      // Error adding service
      print('Error adding service');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: size.height * 0.1,
            top: size.height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 90, 0),
                child: Text(
                  "Add New Service",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 30,
                      ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0x80E0E0E0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      controller: Service_name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Service Name",
                        labelStyle: TextStyle(color: Color(0xFFE34234)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0x80E0E0E0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      controller: Service_category,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Service Description",
                        labelStyle: TextStyle(color: Color(0xFFE34234)),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0x80E0E0E0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      controller: Service_price,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Service Price",
                        labelStyle: TextStyle(color: Color(0xFFE34234)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Select Image:",
                          style:
                              TextStyle(fontSize: 17, color: Color(0xFFE34234)),
                        ),
                      ),
                      SizedBox(width: size.width * 0.3),
                      MaterialButton(
                        onPressed: () {
                          _getImage();
                        },
                        elevation: 0,
                        padding: EdgeInsets.all(18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Color(0xFFabb5be),
                        child: Center(
                          child: Text(
                            "Browse",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  if (image != null)
                    Center(
                      child: Image.file(
                        image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        isChecked = value!;
                        setState(() {});
                      }),
                  Text(
                      "If you need any help than click"),
                ],
              ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      await _uploadService();
                    },
                    elevation: 0,
                    padding: EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Color(0xFFE34234),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}