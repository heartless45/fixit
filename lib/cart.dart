import 'dart:convert';

import 'package:flutter/material.dart';
import 'home.dart';
import 'category.dart';
import 'profile.dart';
import 'api.dart';
import 'package:http/http.dart' as http;



class Cart extends StatefulWidget {
  final int? uid;
  Cart({required this.uid});

  @override
  State<Cart> createState() => _CartState();
}


class _CartState extends State<Cart> {
  late DateTime selectedDateTime;// To store the selected date and time

  int _selectedIndex = 3;

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


  // Inside your _CartState class
  List<dynamic> service = [];

  Future<void> fetchCartData() async {
    final response = await http.post(
      Uri.parse(apiUrl + 'fetch_cart.php'),
      body: {'uid': widget.uid.toString()},
    );

    if (response.statusCode == 200) {
      setState(() {
        service = json.decode(response.body);
      });
    } else {
      print('Failed to fetch cart data: ${response.body}');
    }
  }

  Future<void> deleteCartItem(int cartId) async {
    final response = await http.post(
      Uri.parse(apiUrl + 'delete_cart_item.php'),
      body: {'cart_id': cartId.toString()},
    );

    if (response.statusCode == 200) {
      fetchCartData();
    } else {
      print('Failed to delete cart item: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCartData();
    selectedDateTime = DateTime
        .now(); // Initialize selectedDateTime with current date and time
  }

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        backgroundColor: Color(0xFF11141C),
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
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
                  color: Color(0xFF11141C),
                  padding: EdgeInsets.only(top: 3, bottom: 3),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Color(0xFF212839),
                          padding: EdgeInsets.only(top: 32),
                          margin: EdgeInsets.only(bottom: 7),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: service.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> item = service[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 4, left: 25, right: 25),
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 4),
                                            width: double.infinity,
                                            child: Text(
                                              item['s_name'],
                                              style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '₹'+item['s_price'],
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 16,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (item['c_id'] != null) {
                                              deleteCartItem(int.parse(item['c_id']));
                                            } else {
                                              // Handle null value, e.g., show an error message
                                              print('Cart ID is null.');
                                            }
                                            print(item['c_id']);
                                          },
                                          icon: Icon(Icons.delete),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(bottom: 33, left: 11, right: 11),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date/Time :',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  // Show date picker
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDateTime,
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2025),
                                  );

                                  if (pickedDate != null) {
                                    // Show time picker
                                    final pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          selectedDateTime),
                                    );

                                    if (pickedTime != null) {
                                      // Combine date and time
                                      setState(() {
                                        selectedDateTime = DateTime(
                                          pickedDate.year,
                                          pickedDate.month,
                                          pickedDate.day,
                                          pickedTime.hour,
                                          pickedTime.minute,
                                        );
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  '${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year} ${selectedDateTime.hour}:${selectedDateTime.minute}',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                width: 83, // Adjusted width
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            // Show date picker
                                            final pickedDate =
                                            await showDatePicker(
                                              context: context,
                                              initialDate: selectedDateTime,
                                              firstDate: DateTime(2023),
                                              lastDate: DateTime(2025),
                                            );

                                            if (pickedDate != null) {
                                              // Show time picker
                                              final pickedTime =
                                              await showTimePicker(
                                                context: context,
                                                initialTime:
                                                TimeOfDay.fromDateTime(
                                                    selectedDateTime),
                                              );

                                              if (pickedTime != null) {
                                                // Combine date and time
                                                setState(() {
                                                  selectedDateTime = DateTime(
                                                    pickedDate.year,
                                                    pickedDate.month,
                                                    pickedDate.day,
                                                    pickedTime.hour,
                                                    pickedTime.minute,
                                                  );
                                                });
                                              }
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              color: Color(0xFFD9D9D9),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 16),
                                            // Adjusted padding
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Select',
                                                  style: TextStyle(
                                                    color: Color(0xFF14121C),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 130,),
                        GestureDetector(
                          onTap: () {
                            // Next button logic
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFD9D9D9),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 13),
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            width: double.infinity,
                            child: Column(
                              children: [
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Color(0xFF141821),
                                    fontSize: 25,
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