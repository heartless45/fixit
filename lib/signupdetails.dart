import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'api.dart';

class SignUpdetails extends StatefulWidget {
  final String email;
  final String password;

  SignUpdetails({required this.email, required this.password});

  @override
  _SignUpdetailsState createState() => _SignUpdetailsState();
}

class _SignUpdetailsState extends State<SignUpdetails> {
  TextEditingController name = TextEditingController();
  TextEditingController Phone = TextEditingController();
  TextEditingController s_name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();


  Future<void> sendDataToBackend() async {
    try {
      final url = Uri.parse(apiUrl+'vendor_details.php');
      final response = await http.post(
        url,
        body: {
          'name': name.text,
          'phone': Phone.text,
          'shop_name': s_name.text,
          'email': widget.email,
          'address': address.text,
          'city': city.text,
          'pincode': pincode.text,
          'password':widget.password,
        },
      );
      if(response.statusCode == 200)
      {
        // print('Data sent successfully');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Signup Complate'),
            content: Text('Now you can login after 24 hours'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );

      }
      else
      {
        print("Some issue");
      }
    } catch (e) {
      print('Error making HTTP request: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(), // Add your AppBar here
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
                  "Enter Your Details",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 30, // Set your fixed font size
                      ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20,
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
                      controller: name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Your Name",
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
                      controller: Phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Phone No",
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
                      controller: s_name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Shop Name",
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
                      controller: address,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Address",
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
                      controller: city,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "City",
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
                      controller: pincode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Pincode",
                        labelStyle: TextStyle(color: Color(0xFFE34234)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      if (
                          name.text.isEmpty ||
                          Phone.text.isEmpty ||
                          address.text.isEmpty ||
                          s_name.text.isEmpty ||
                          pincode.text.isEmpty ||
                          city.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill all details'),
                          ),
                        );
                      } else {
                        await sendDataToBackend();
                      }
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