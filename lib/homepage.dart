import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'customerinfo.dart';
import 'api.dart';


class MyHomePage extends StatefulWidget {

  final int vId;

  MyHomePage({required this.vId});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Booking> bookings = [];

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    final response = await http.post(
      Uri.parse(apiUrl+'Pending_Bookings.php'),
      body: json.encode({'vId': widget.vId.toString()}),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // print(response.body);
      setState(() {
        bookings = data.map((item) => Booking.fromJson(item)).toList();
      });
    } else {
      print('Failed to load bookings: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
              fontSize: 20,
              color: Color(0xFFE34234),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Your Performance',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Divider(height: 5, thickness: 3, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 5, thickness: 3),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Current Week"),
                    SizedBox(height: 20),
                    DashboardItem(progress: 0.30, color: Colors.green),
                  ],
                ),
                Column(
                  children: [
                    Text("Last Week"),
                    SizedBox(height: 20),
                    DashboardItem(progress: 0.40, color: Color(0xFFE34234)),
                  ],
                ),
                Column(
                  children: [
                    Text("Last Month"),
                    SizedBox(height: 20),
                    DashboardItem(progress: 0.90, color: Colors.blue),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Pending Bookings',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 5, thickness: 3),
            ListView.builder(
              shrinkWrap: true,
              itemCount: bookings.length, // Use the length of the bookings list
              itemBuilder: (context, index) {
                return TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerDetail(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bookings[index].customerName,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Rs. ${bookings[index].amount}',
                        style: TextStyle(color: Color(0xFFA3A3A3)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      drawer: MyDrawer(vId: widget.vId,),
    );
  }
}

class DashboardItem extends StatefulWidget {
  final double progress;
  final Color color;

  const DashboardItem({Key? key, required this.progress, required this.color})
      : super(key: key);

  @override
  State<DashboardItem> createState() => _DashboardItemState();
}

class _DashboardItemState extends State<DashboardItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CircularProgressIndicator(
              value: widget.progress,
              strokeWidth: 8,
              backgroundColor: widget.color.withOpacity(0.5),
              valueColor: AlwaysStoppedAnimation<Color>(widget.color),
            ),
          ),
          Center(
            child: Text(
              '${(widget.progress * 100).toInt()}%',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class Booking {
  final String customerName;
  final double amount;

  Booking({required this.customerName, required this.amount});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      customerName: json['customer_name'] ?? 'Unknown',
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
    );
  }
}