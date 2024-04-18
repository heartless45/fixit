import 'package:flutter/material.dart';

class CustomerDetail extends StatefulWidget {
  const CustomerDetail({super.key});

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer’s Details',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFFE34234),
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  color: Color(0xFFFFFFFF),
                  padding: EdgeInsets.only(top: 10, bottom: 20, left: 22, right: 22),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicHeight(
                          child: Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 45),
                                    width: 123,
                                    child: Text(
                                      'Customer Name',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        'Zeel',
                                        style: TextStyle(
                                          color: Color(0xFFA2A2A2),
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 45),
                                    width: 123,
                                    child: Text(
                                      'Service\nName',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        'Ac Service',
                                        style: TextStyle(
                                          color: Color(0xFFA2A2A2),
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 1, right: 4),
                                      width: double.infinity,
                                      child: Text(
                                        'Customer’s\nAddress',
                                        style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Container(
                                    width: 173,
                                    child: Text(
                                      'Ajay tenaments\npart-2 Opp.\nbharat party plot\nAmaraiwadi\nAhamadabad,360026',
                                      style: TextStyle(
                                        color: Color(0xFFA2A2A2),
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 85),
                                    width: 82,
                                    child: Text(
                                      'Service\nPrice',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 1),
                                      width: double.infinity,
                                      child: Text(
                                        'Rs250',
                                        style: TextStyle(
                                          color: Color(0xFFA2A2A2),
                                          fontSize: 24,
                                        ),
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
