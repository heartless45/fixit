import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'welcome.dart';
import 'api.dart';

class address extends StatefulWidget {
  final String? phoneno;
  final String name;
  final String email;

  address({required this.phoneno,required this.name,required this.email});

  @override
  State<address> createState() => _addressState();
}

class _addressState extends State<address> {
  TextEditingController Address = TextEditingController();
  TextEditingController Landmark = TextEditingController();
  TextEditingController Pincode = TextEditingController();

  String? selectedCity;

  void sendDataToServer() async {
    var url = apiUrl + 'user_reg.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'phoneno': widget.phoneno,
        'name': widget.name,
        'email': widget.email,
        'address': Address.text,
        'landmark': Landmark.text,
        'pincode': Pincode.text,
        'city': selectedCity ?? '',
      });

      if (response.statusCode == 200) {
          print('Data stored successfully');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Welcome(phoneno: widget.phoneno,)),
          );
      } else {
        print('Error storing data - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error sending data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFF11141C),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.only( bottom: 10, left: 145, right: 145),
                            height: 100,
                            width: double.infinity,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/f1.png',
                                  fit: BoxFit.fill,
                                )
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Center(
                            child: Text(
                              'Address\n',
                              textAlign: TextAlign.center, // Center the text horizontally
                              style: TextStyle(
                                color: Color(0xFF8C8C8C),
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: Color(0xFF999999),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Select City',
                              hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                            items: <String>['Ahmedabad','Vastral','Sarkhej','Naranpura', 'Other']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Color(0xFF000000)),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              selectedCity = value;
                            },
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                        ),
                        // Street Address Field
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            controller:Address,
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                            decoration: InputDecoration(
                              hintText: 'Street Address*',
                              hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
                              fillColor: Color(0xFF999999),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                            ),
                          ),
                        ),
                        // Landmark Field
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            controller:Landmark,
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                            decoration: InputDecoration(
                              hintText: 'Landmark',
                              hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
                              fillColor: Color(0xFF999999),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                            ),
                          ),
                        ),
                        // Postal Code Field
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            controller:Pincode,
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Pincode Code*',
                              hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
                              fillColor: Color(0xFF999999),
                              filled: true,
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                            ),
                          ),
                        ),
                        // Button
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              sendDataToServer();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD9D9D9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: Text(
                                'READY TO GO!',
                                style: TextStyle(
                                  color: Color(0xFF141821),
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}