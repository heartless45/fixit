import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'category.dart';
import 'home.dart';
import 'api.dart';
import 'cart.dart';

class Profile extends StatefulWidget {
  final int? uid;
  Profile({required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(uid: widget.uid)),
      );
    }
    else if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => category(uid: widget.uid)),
      );
    }
    else if (_selectedIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile(uid: widget.uid)),
      );
    }
    else if (_selectedIndex == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Cart(uid: widget.uid)),
      );
    }
  }

  String name = '';
  String email = '';
  String Landmark = '';
  String mobileNo = '';
  String address = '';
  String city = '';
  String pinCode = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _LandmarkController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Function to fetch data from PHP script
  Future<void> fetchData() async {
    final response =
    await http.get(Uri.parse(apiUrl +'user_profile.php?id=${widget.uid}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        name = data['u_name'];
        email = data['email'];
        mobileNo = data['phone'];
        address = data['u_address'];
        Landmark = data['landmark'];
        city = data['city'];
        pinCode = data['pincode'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = name;
    _emailController.text = email;
    _mobileNoController.text = mobileNo;
    _addressController.text = address;
    _LandmarkController.text = Landmark;
    _cityController.text = city;
    _pinCodeController.text = pinCode;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Color of the selected item
        unselectedItemColor: Color(0xFF11141C), // Color of unselected items
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFF141821),
                  padding: EdgeInsets.only(top: 15, bottom: 45),
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
                          margin: EdgeInsets.symmetric(horizontal: 21),
                          height: 52,
                          child: Row(
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
                              SizedBox(width: 8), // Add spacing between the image and text
                              Text(
                                'Profile',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 23,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 30,),

                        Container(
                          margin: EdgeInsets.only(bottom: 8, left: 25, right: 25),
                          child: Text(
                            'Name',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF534C4C),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            //padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(bottom: 18, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF141821),
                                contentPadding: EdgeInsets.only(left: 15, right: 15),
                                
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 9, left: 25, right: 25),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF534C4C),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            //padding: EdgeInsets.only(top: 16, bottom: 16, left: 15, right: 15),
                            margin: EdgeInsets.only(bottom: 19, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF141821),
                                contentPadding: EdgeInsets.only(left: 15, right: 15),

                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 9, left: 25, right: 25),
                          child: Text(
                            'Phone No',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF534C4C),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            //padding: EdgeInsets.only(top: 16, bottom: 16, left: 15, right: 15),
                            margin: EdgeInsets.only(bottom: 19, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _mobileNoController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF141821),
                                contentPadding: EdgeInsets.only(left: 15, right: 15),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 9, left: 25, right: 25),
                          child: Text(
                            'Address',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF534C4C),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            //padding: EdgeInsets.only(top: 16, bottom: 16, left: 15, right: 15),
                            margin: EdgeInsets.only(bottom: 19, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF141821),
                                contentPadding: EdgeInsets.only(left: 15, right: 15),

                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 9, left: 25, right: 25),
                          child: Text(
                            'Landmark',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF534C4C),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            //padding: EdgeInsets.only(top: 16, bottom: 16, left: 15, right: 15),
                            margin: EdgeInsets.only(bottom: 19, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _LandmarkController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF141821),
                                contentPadding: EdgeInsets.only(left: 15, right: 15),

                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 9, left: 25, right: 25),
                          child: Text(
                            'City',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF534C4C),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            //padding: EdgeInsets.only(top: 16, bottom: 16, left: 15, right: 15),
                            margin: EdgeInsets.only(bottom: 19, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _cityController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF141821),
                                contentPadding: EdgeInsets.only(left: 15, right: 15),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 9, left: 25, right: 25),
                          child: Text(
                            'Pincode',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF534C4C),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            //padding: EdgeInsets.only(top: 16, bottom: 16, left: 15, right: 15),
                            margin: EdgeInsets.only(bottom: 19, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _pinCodeController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF141821),
                                contentPadding: EdgeInsets.only(left: 15, right: 15),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          margin: EdgeInsets.symmetric(horizontal: 79),
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your onPressed logic here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD9D9D9),// Background color
                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(6),
                              ),
                              fixedSize: Size(221, 59),
                            ),
                            child: Text(
                              'Save changes',
                              style: TextStyle(
                                color: Color(0xFF14121C),
                                fontSize: 20,
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