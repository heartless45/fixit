import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'addservice.dart';
import 'api.dart';

class ServicesPage extends StatefulWidget {
  final int vId;

  ServicesPage({required this.vId});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<Service> services = [];

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  Future<void> fetchServices() async {
    final response = await http.post(
      Uri.parse(apiUrl+'get_services.php'),
      body: json.encode({'vId': widget.vId.toString()}),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        services = data.map((item) => Service.fromJson(item)).toList();
      });
    } else {
      print('Failed to load services: ${response.body}');
    }
  }

  Future<void> _refreshServices() async {
    await fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE34234),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshServices,
        child: Column(
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
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => addservice(
                                  vId: widget.vId,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Add New Services',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 5, thickness: 3),
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(service.name, style: TextStyle(color: Colors.black)),
                        Text(service.price.toString(), style: TextStyle(color: Color(0xFFA3A3A3))),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(
        vId: widget.vId,
      ),
    );
  }
}

class Service {
  final String name;
  final double price;

  Service({required this.name, required this.price});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['s_name'],
      price: double.parse(json['s_price']),
    );
  }
}
