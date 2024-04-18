import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'api.dart';
import 'drawer.dart';

class Profile extends StatefulWidget {
  final int vId;

  Profile({required this.vId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name = '';
  String email = '';
  String shopName = '';
  String mobileNo = '';
  String address = '';
  String city = '';
  String pinCode = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
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
    await http.get(Uri.parse(apiUrl+'setting.php?id=${widget.vId}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        name = data['vendor_name'];
        email = data['v_email'];
        shopName = data['shop_name'];
        mobileNo = data['v_phone'];
        address = data['v_address'];
        city = data['v_city'];
        pinCode = data['v_pincode'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {

    _nameController.text = name;
    _emailController.text = email;
    _shopNameController.text = shopName;
    _mobileNoController.text = mobileNo;
    _addressController.text = address;
    _cityController.text = city;
    _pinCodeController.text = pinCode;

    return Scaffold(
      appBar: AppBar(title: Text(
        'Profile',
        style: TextStyle(
            fontSize: 20,
            color: Color(0xFFE34234),
            fontWeight: FontWeight.bold),
      ),),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFFFAFAFA),
                  padding: EdgeInsets.only(top: 15, bottom: 45),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          margin: EdgeInsets.only(bottom: 8,
                              left: 25,
                              right: 25),
                          child: Text(
                            'Name',
                            style: TextStyle(
                              color: Color(0xFF1A0101),
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
                            margin: EdgeInsets.only(
                                bottom: 18, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                //contentPadding: EdgeInsets.all(16),
                                hintText: 'Melissa Peters',
                                hintStyle: TextStyle(
                                  color: Color(0xFF534C4C),
                                  fontSize: 14,
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF534C4C),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 9,
                              left: 25,
                              right: 25),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              color: Color(0xFF1A0101),
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
                            margin: EdgeInsets.only(
                                bottom: 19, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                // contentPadding: EdgeInsets.only(top: 16, bottom: 16, left: 15, right: 15),
                                hintText: 'melpeters@gmail.com',
                                hintStyle: TextStyle(
                                  color: Color(0xFF534C4C),
                                  fontSize: 14,
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF534C4C),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8,
                              left: 25,
                              right: 25),
                          child: Text(
                            'Shop Name',
                            style: TextStyle(
                              color: Color(0xFF1A0101),
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
                            margin: EdgeInsets.only(
                                bottom: 18, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _shopNameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                //contentPadding: EdgeInsets.all(16),
                                hintText: 'Shreeji Motors',
                                hintStyle: TextStyle(
                                  color: Color(0xFF534C4C),
                                  fontSize: 14,
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF534C4C),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8,
                              left: 25,
                              right: 25),
                          child: Text(
                            'Mobile No',
                            style: TextStyle(
                              color: Color(0xFF1A0101),
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
                            margin: EdgeInsets.only(
                                bottom: 18, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _mobileNoController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                //contentPadding: EdgeInsets.all(16),
                                hintText: '+91 9865235698',
                                hintStyle: TextStyle(
                                  color: Color(0xFF534C4C),
                                  fontSize: 14,
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF534C4C),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8,
                              left: 25,
                              right: 25),
                          child: Text(
                            'Address',
                            style: TextStyle(
                              color: Color(0xFF1A0101),
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
                            margin: EdgeInsets.only(
                                bottom: 18, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                //contentPadding: EdgeInsets.all(16),
                                hintText: 'Shreeji Motors, Commerce College Road, Vasant Vihar, Navrangpura',
                                hintStyle: TextStyle(
                                  color: Color(0xFF534C4C),
                                  fontSize: 14,
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF534C4C),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8,
                              left: 25,
                              right: 25),
                          child: Text(
                            'City',
                            style: TextStyle(
                              color: Color(0xFF1A0101),
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
                            margin: EdgeInsets.only(
                                bottom: 18, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _cityController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                //contentPadding: EdgeInsets.all(16),
                                hintText: ' Ahmedabad',
                                hintStyle: TextStyle(
                                  color: Color(0xFF534C4C),
                                  fontSize: 14,
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF534C4C),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8,
                              left: 25,
                              right: 25),
                          child: Text(
                            'Pin Code',
                            style: TextStyle(
                              color: Color(0xFF1A0101),
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
                            margin: EdgeInsets.only(
                                bottom: 18, left: 24, right: 24),
                            width: double.infinity,
                            child: TextField(
                              controller: _pinCodeController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                //contentPadding: EdgeInsets.all(16),
                                hintText: ' 380009',
                                hintStyle: TextStyle(
                                  color: Color(0xFF534C4C),
                                  fontSize: 14,
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF534C4C),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xFF1A0101),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            margin: EdgeInsets.symmetric(horizontal: 79),
                            width: 221,
                            height: 59,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your button functionality here
                                print('Button pressed!');
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Color(0xFFD9D9D9),
                                backgroundColor: Color(0xFF1A0101),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Text(
                                'Save changes',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(vId: widget.vId,),
    );
  }
}