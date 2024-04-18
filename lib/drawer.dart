import 'package:flutter/material.dart';
import 'homepage.dart';
import 'services.dart';
import 'customers.dart';
import 'paymentdetails.dart';
import 'setting.dart';

class MyDrawer extends StatefulWidget {
  final int vId;

  MyDrawer({required this.vId});
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/icons/fixit.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'user@example.com',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(vId: widget.vId,)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.design_services_rounded),
            title: Text('Your Services'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServicesPage(vId: widget.vId,)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_search),
            title: Text('Customers'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Customer(vId: widget.vId,)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.payment_outlined),
            title: Text('Payments'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Payment(vId: widget.vId,)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile(vId: widget.vId,)),
              );
            },
          ),
        ],
      ),
    );
  }
}
