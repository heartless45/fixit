import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp1.dart';

class Signup2 extends StatefulWidget {
  const Signup2({Key? key});

  @override
  State<Signup2> createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {

  final TextEditingController _phoneNumberController = TextEditingController();

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification failed: ${e.message}'),
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Otp1(verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                            borderRadius: BorderRadius.circular(screenWidth),
                            color: Color(0xFF141821),
                          ),
                          margin: EdgeInsets.only(
                            bottom: screenHeight * 0.02,
                            left: screenWidth * 0.01,
                            right: screenWidth * 0.01,
                          ),
                          width: screenWidth * 0.12,
                          height: screenWidth * 0.12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: screenHeight * 0.005),
                                width: screenWidth * 0.09,
                                height: screenWidth * 0.09,
                                child: Image.asset(
                                  'assets/f1.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: screenHeight * 0.015,
                            left: screenWidth * 0.08,
                            right: screenWidth * 0.08,
                          ),
                          width: double.infinity,
                          child: Text(
                            'Give us your \nmobile number',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: screenHeight * 0.025,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: screenHeight * 0.038,
                            left: screenWidth * 0.07,
                            right: screenWidth * 0.07,
                          ),
                          width: double.infinity,
                          child: Text(
                            'to start we need your mobile number',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: screenHeight * 0.025,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF11141C),
                          ),
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.013,
                            bottom: screenHeight * 0.013,
                            left: screenWidth * 0.019,
                            right: screenWidth * 0.019,
                          ),
                          margin: EdgeInsets.only(
                            bottom: screenHeight * 0.426,
                            left: screenWidth * 0.07,
                            right: screenWidth * 0.07,
                          ),
                          width: screenWidth * 0.490,
                          height: screenHeight * 0.101,
                          child: TextField(
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              hintText: 'Ex. 8866004511', // Set the initial text as hint
                              hintStyle: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: screenHeight * 0.038,
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: screenHeight * 0.036,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(screenWidth * 0.1),
                            color: Color(0xFFD9D9D9),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF8C8C8C),
                                blurRadius: screenHeight * 0.03,
                                offset: Offset(0, screenHeight * 0.01),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.007),
                          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.144),
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              String phoneNumber = '+91${_phoneNumberController.text}'; // Add your country code here
                              _verifyPhoneNumber(phoneNumber);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF000000), // Use foregroundColor instead of primary
                            ),
                            child: Text(
                              'GET STARTED',
                              style: TextStyle(
                                color: const Color(0xFF000000),
                                fontSize: screenHeight * 0.036,
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
