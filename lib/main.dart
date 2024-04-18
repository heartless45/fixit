import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signup2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCgwYEN3a0EzZmZj1tZw7Gz6jgDLsVRJgc",
          authDomain: "capname-8639b.firebaseapp.com",
          projectId: "capname-8639b",
          storageBucket: "capname-8639b.appspot.com",
          messagingSenderId: "302652255490",
          appId: "1:302652255490:web:ea1c20eb46392884eea61b"
      ));
  runApp(MaterialApp(home: SplashScreen()));
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double containerHeight = screenHeight * 0.9;
    double containerMargin = screenHeight * 0.5;

    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Color(0xFFFFFFFF),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFF11141C),
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    bottom: screenHeight * 0.08,
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.only(
                            bottom: screenHeight * 0.58,
                            left: screenWidth * 0.04,
                            right: screenWidth * 0.04,
                          ),
                          width: screenWidth * 0.25,
                          height: screenWidth * 0.25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/f1.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: screenHeight * 0.03,
                            left: screenWidth * 0.2,
                            right: screenWidth * 0.2,
                          ),
                          width: double.infinity,
                          child: Text(
                            'Home, Simplified.',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: screenHeight * 0.03,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFFD9D9D9),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF8C8C8C),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.007,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                          ),
                          width: double.infinity,
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Signup2(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                  const Color(0xFF000000),
                                  // Use foregroundColor instead of primary
                                ),
                                child: Text(
                                  'GET STARTED',
                                  style: TextStyle(
                                    color: const Color(0xFF000000),
                                    // You can also use Colors.black here if preferred
                                    fontSize: screenHeight * 0.03,
                                  ),
                                ),
                              ),
                            ],
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
