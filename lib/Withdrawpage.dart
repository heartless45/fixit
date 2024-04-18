import 'package:flutter/material.dart';

class Withdrawpage extends StatefulWidget {
  @override
  _WithdrawpageState createState() => _WithdrawpageState();
}

class _WithdrawpageState extends State<Withdrawpage> {
  bool isChecked = true;

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
                  "Withdraw Amount",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 30, // Set your fixed font size
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0x80E0E0E0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Enter Your UPI ID",
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
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0x80E0E0E0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Enter Amount",
                        labelStyle: TextStyle(color: Color(0xFFE34234)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                          "Your Amount will be transferred into\n3-4 working days"),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: () {
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
                  SizedBox(
                    height: 10,
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