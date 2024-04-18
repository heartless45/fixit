import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'signup.dart';
import 'homepage.dart';
import 'api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse(apiUrl+'vendor_login.php'),
        body: {'email': email, 'password': password},
      );

      // print('Response Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');


      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData != null && responseData['status'] == 'success') {
          final bool isApproved = responseData['message'] == 'Login successful';
          if (isApproved) {
            final int vId = int.parse(responseData['v_id']);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(vId: vId,)),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Login Failed'),
                content: Text(responseData['message']),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Login Failed'),
              content: Text(responseData['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Connection Error'),
            content: Text('Failed to connect to server.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(error.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Column(
                      children: [
                        Image(
                          width: 50,
                          image: AssetImage('assets/icons/fixit.jpg'),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "FIXIT",
                          style: TextStyle(
                            color: Color(0xFF989EB1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 90, 0),
                    child: Text(
                      "Sign In,",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 40, // Set your fixed font size
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "HI there! Nice to see you again.",
                      style: TextStyle(
                        color: Color(0xFF989EB1),
                      ),
                    ),
                  ),
                ],
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
                      controller: _emailController,
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
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Password",
                        labelStyle: TextStyle(color: Color(0xFFE34234)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                    style: TextButton.styleFrom(
                      // Remove primary here
                    ),
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      await _login(context);
                    },
                    elevation: 0,
                    padding: EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Color(0xFFE34234),
                    child: Center(
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                      // Add your onPressed logic here
                    },
                    style: TextButton.styleFrom(
                      // Remove primary here
                    ),
                    child: Text(
                      "Create account",
                      style: Theme.of(context).textTheme.bodyText1,
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
