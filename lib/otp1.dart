import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'name.dart';
import 'welcome_back.dart';

class Otp1 extends StatefulWidget {

  final String verificationId;
  Otp1(this.verificationId);

  @override
  State<Otp1> createState() => _Otp1State();
}

class _Otp1State extends State<Otp1> {

  final TextEditingController _smsController = TextEditingController();

  void _submitOTP(String smsCode) async {
    try {
      // Verify the OTP and get the PhoneAuthCredential
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );

      // Sign in with the obtained credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the current user's phone number
      String? phoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;

      // Check if the phone number exists in your database
      bool phoneNumberExists = await checkIfPhoneNumberExistsInDatabase(phoneNumber);

      if (phoneNumberExists) {
        // Redirect to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Welcomeback(phoneno: phoneNumber),
          ),
        );
      } else {
        // Store the phone number into the database
        await storePhoneNumberInDatabase(phoneNumber);

        // Redirect to the name page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => name(phoneno: phoneNumber),
          ),
        );
      }
    } catch (e) {
      // Handle any errors, for example, invalid OTP
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid OTP. Please try again.'),
        ),
      );
    }
  }

  Future<bool> checkIfPhoneNumberExistsInDatabase(String? phoneNumber) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Query the collection for documents where the phoneNumber field equals the provided phoneNumber
      QuerySnapshot querySnapshot = await users.where('phoneNumber', isEqualTo: phoneNumber).get();

      // Check if any documents were returned
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Handle any errors
      print("Error checking phone number existence: $e");
      return false; // Return false if an error occurs
    }
  }

// Function to store the phone number into the database
  Future<void> storePhoneNumberInDatabase(String? phoneNumber) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.add({'phoneNumber': phoneNumber});
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            color: Color(0xFF141821),
                          ),
                          margin: EdgeInsets.only(bottom: 19, left: 5, right: 5),
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
                          margin: EdgeInsets.only(bottom: 21, left: 32, right: 32),
                          width: double.infinity,
                          child: Text(
                            'We have sent you \nan OTP',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 2, left: 32, right: 32),
                          width: double.infinity,
                          child: Text(
                            'enter the 6 digit\nto proceed',
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
                          padding: EdgeInsets.only( bottom: 5),
                          margin: EdgeInsets.only(bottom: 15, left: 32, right: 39),
                          width: 162,
                          height: 105,
                          child: Column(
                            children: [
                              TextField(
                                controller: _smsController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF11141C),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 40,
                                ),
                                textAlign: TextAlign.center, // Optional, adjust alignment as needed
                              ),
                            ],
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFF20242E),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 18),
                          margin: EdgeInsets.only(bottom: 179, left: 32, right: 32),
                          width: 140,
                          height: 60,
                          child: Column(
                            children: [
                              Text(
                                'Resend OTP',
                                style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF11141C),
                            ),
                            padding: EdgeInsets.only(left: 65, right: 65),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _submitOTP(_smsController.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ), backgroundColor: Color(0xFFD9D9D9),
                                      padding: EdgeInsets.symmetric(vertical: 23),
                                      minimumSize: Size(double.infinity, 0), // Adjust as needed
                                    ),
                                    child: Text(
                                      'READY TO GO!',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 24,
                                      ),
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

