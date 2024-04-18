import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'api.dart';

class Welcomeback extends StatefulWidget {
  final String? phoneno;

  Welcomeback({required this.phoneno});

  @override
  State<Welcomeback> createState() => _WelcomebackState();
}

class _WelcomebackState extends State<Welcomeback> {
  int? uId;

  @override
  void initState() {
    super.initState();
    fetchData(); // Call fetchData method to fetch data from server
  }

  Future<void> fetchData() async {
    // print(widget.phoneno);
    final url = apiUrl + 'get_uid.php';
    final response = await http.post(Uri.parse(url), body: {
      'phoneNumber': widget.phoneno ?? '',
    });

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        setState(() {
          // print(response.body);
          uId = int.tryParse(data['u_id']) ?? 0;
        });
      } else {
        // Handle empty response, such as displaying a message to the user
        print('No data found for the provided phone number');
      }
    } else {
      throw Exception('Failed to fetch data');
    }

    // Delay navigation to the home page
    Future.delayed(Duration(seconds: 5), () {
      //print(uId);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(uid: uId,)),
      );
    });
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
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF141821),
                            ),
                            padding: EdgeInsets.only(top: 378, bottom: 402, left: 35, right: 35),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left : 25),
                                  width: double.infinity,
                                  child: Text(
                                    'Welcome to FIXIT',
                                    style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 32,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 32,
                                    ),
                                  ),
                                ),
                              ],
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
