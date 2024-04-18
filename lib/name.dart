import 'package:flutter/material.dart';
import 'email.dart';

class name extends StatefulWidget {
  final String? phoneno;

  name({required this.phoneno});
  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {

  TextEditingController name = TextEditingController();
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            color: Color(0xFF141821),
                          ),
                          margin: EdgeInsets.only(bottom: 18, left: 6, right: 6),
                          width: 53,
                          height: 52,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                width: 43,
                                height: 43,
                                child: Image.asset(
                                  'assets/f1.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20, left: 33, right: 33),
                          width: double.infinity,
                          child: Text(
                            'this is necessary to proceed further',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 21, left: 33, right: 33),
                          width: double.infinity,
                          child: Text(
                            'tell us your full \nname',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 20,
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF11141C),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 17),
                          margin: EdgeInsets.only(bottom: 1, left: 30, right: 32),
                          width: 260,
                          height: 151,
                          child: Column(
                            children: [
                              TextField(
                                controller:name,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF11141C),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey), // Color of the bottom border
                                  ),
                                ),
                                style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 35,
                                ),
                                keyboardType: TextInputType.text, // Adjust keyboard type as needed
                                textAlign: TextAlign.left, // Optional, adjust alignment as needed
                                maxLength: 20, // Adjust maximum length as needed
                              ),

                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 147, left: 32, right: 32),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => email(name: name.text, phoneno: widget.phoneno,)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ), backgroundColor: Color(0xFFD9D9D9),
                              padding: EdgeInsets.symmetric(vertical: 22),
                              minimumSize: Size(142, 78),
                            ),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),

                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF141821),
                            ),
                            width: double.infinity,
                            child: SizedBox(),
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
