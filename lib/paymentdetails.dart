import 'package:flutter/material.dart';
import 'drawer.dart';
import 'Withdrawpage.dart';

class Payment extends StatefulWidget {
  final int vId;

  Payment({required this.vId});
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE34234),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Withdrawpage()),
              );
            },
            child: Text('2300 Rs.'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              decoration: BoxDecoration(
                color: Color(0x80E0E0E0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Search Payments",
                  labelStyle: TextStyle(color: Color(0xFFA3A3A3)),
                  prefixIcon: Icon(Icons.search, color: Color(0xFFA3A3A3)),
                  contentPadding: EdgeInsets.only(right: 10),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer Name ${index + 1}',
                            style: TextStyle(color: Colors.black),
                          ),
                          Text('1300 Rs.'),
                        ],
                      ),
                    ),
                    if (index < 14 &&
                        (index + 1) % 3 ==
                            0) // Add larger divider after every third item
                      Container(
                          height: 5,
                          child:
                              Divider(thickness: 15, color: Color(0x80E0E0E0))),
                    if (index < 14 &&
                        (index + 1) % 3 !=
                            0) // Add smaller divider after each customer except the last one
                      Divider(height: 1, color: Color(0x80E0E0E0)),
                  ],
                );
              },
              childCount: 15,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(vId: widget.vId,),
    );
  }
}
