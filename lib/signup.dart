import 'dart:convert';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signupdetails.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> checkEmailAvailability(BuildContext context, String email) async {
    final response = await http.post(
      Uri.parse(apiUrl+'vendor_reg.php'),
      body: {'email': email},
    );

    // print('Response Status Code: ${response.statusCode}');
    // print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['available'] == true) {
        String psw = password.text;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpdetails(
              email: email,
              password: psw,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email is already registered'),
          ),
        );
      }
    } else {
      // Failed to check email availability
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to check email availability'),
        ),
      );
      throw Exception('Failed to check email availability');
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
                  "Sign Up",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 40, // Set your fixed font size
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
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0x80E0E0E0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Email or Phone number",
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
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Password",
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
                          "I agree to the Terms of Services and\nPrivacy Policy"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      if (email.text.isEmpty) {
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email is required'),
                            ),
                          );
                        });
                      } else {
                        if (password.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Password is required'),
                            ),
                          );
                          setState(() {});
                        } else {
                          if (password.text.length < 8) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Password must be at least 8 characters.'),
                              ),
                            );
                          } else if (!RegExp(r'[A-Z]').hasMatch(password.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Password must contain at least 1 uppercase letter.'),
                              ),
                            );
                          } else if (!RegExp(r'[0-9]').hasMatch(password.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Password must contain at least 1 number.'),
                              ),
                            );
                          } else if (!RegExp(r'[!@#$%^&*()_+{}|<>?]').hasMatch(password.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Password must contain at least 1 special character.'),
                              ),
                            );
                          } else {
                            try {
                              if(isChecked == true){
                                await checkEmailAvailability(context,email.text);
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Plz agree the Terms & Policy'),
                                  ),
                                );
                              }

                            } catch (e) {
                              print('Error checking email availability: $e');
                            }
                          }
                        }
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an Account? ",
                        style: TextStyle(
                          color: Color(0xFF989EB1),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                          // Add your onPressed logic here
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Color(0xFFE34234)),
                        ),
                      ),
                    ],
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
