import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

class DisplayProduct extends StatefulWidget {
  final int? uid;
  final String? service;
  DisplayProduct({required this.uid,required this.service});

  @override
  State<DisplayProduct> createState() => _DisplayProductState();
}

class _DisplayProductState extends State<DisplayProduct> {
  List<dynamic> products = []; // List to store fetched products

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Call the method to fetch products when widget initializes
  }

  Future<void> fetchProducts() async {
    final response = await http.post(
      Uri.parse(apiUrl + 'get_product.php'), // Replace with your PHP script URL
      body: {'uid': widget.uid.toString(),
        'service':widget.service,
      }, // Pass any necessary parameters
    );

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body); // Parse JSON response and update products list
      });
    } else {
      print('Failed to fetch products: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF11141C),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xFF11141C),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> product = products[index];
                return Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF212839), // Change the color of the Card here
                      borderRadius: BorderRadius.circular(10), // Optional: Add border radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                apiUrl_ing + (products[index]["s_image"] ?? "N/A"), // Assuming 'imageUrl' is the key for product image URL
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${products[index]["s_name"] ?? "N/A"}', // Assuming 'name' is the key for product name
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Rs. ${products[index]["s_price"] ?? "N/A"}', // Assuming 'price' is the key for product price
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,

                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${products[index]["s_description"] ?? "N/A"}', // Assuming 'price' is the key for product price
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,

                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFD9D9D9),
                                          borderRadius: BorderRadius.circular(7),
                                        ),
                                        child: Center(
                                          child: TextButton(
                                            onPressed: () async{
                                              final response = await http.post(
                                                Uri.parse(apiUrl + 'add_to_cart.php'),
                                                body: {'uid': widget.uid.toString(), 'service': products[index]["s_name"]},
                                              );

                                              if (response.statusCode == 200) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text('Success'),
                                                      content: Text('Product added to cart.'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                // Failed to add to cart
                                                print('Failed to add product to cart: ${response.body}');
                                              }
                                            },
                                            child: Text(
                                              'ADD',
                                              style: TextStyle(color: Color(0xFF14121C),),
                                            ),
                                          )

                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

