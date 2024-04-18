import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user/api.dart';
import 'category.dart';
import 'product.dart';
import 'profile.dart';
import 'cart.dart';


class Home extends StatefulWidget {
  final int? uid;
  Home({required this.uid});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  String city = "";
  String landmark = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse(apiUrl+'city_area.php'),
      body: {'uid': widget.uid.toString()},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        city = jsonData['city']as String;
        landmark = jsonData['landmark']as String;
      });
    } else {
      // Handle error
      print('Failed to load user data');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(uid: widget.uid,)),
      );
    }
    else if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => category(uid: widget.uid,)),
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
                  padding: EdgeInsets.only(top: 9, bottom: 1),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: double.infinity,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 29,
                                              width: 46,
                                              child: Icon(
                                                Icons.location_pin,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            // Adjust the spacing between icon and text
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  city.isNotEmpty ? city : 'Loading...',
                                                  style: TextStyle(
                                                    color: Color(0xFF999999),
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  landmark.isNotEmpty ? landmark : 'Loading...',
                                                  style: TextStyle(
                                                    color: Color(0xFF999999),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 25),
                                    width: 53,
                                    child: Stack(children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IntrinsicHeight(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          500),
                                                  color: Color(0xFF141821),
                                                ),
                                                width: double.infinity,
                                                child: SizedBox(),
                                              ),
                                            ),
                                          ]),
                                      Positioned(
                                          top: 0,
                                          right: 13,
                                          width: 26,
                                          height: 15,
                                          child: Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      0, -13, 0),
                                              width: 26,
                                              height: 15,
                                              child: Icon(
                                                Icons.search,
                                                size: 40,
                                                color: Colors.white,
                                              ))),
                                    ]),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(7),
                            color: Color(0xFFECECEC),
                          ),
                          padding: EdgeInsets.only(
                              top: 6, bottom: 6, left: 5, right: 5),
                          margin:
                              EdgeInsets.only(bottom: 41, left: 10, right: 10),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                width: 38,
                                height: 34,
                                child: Icon(
                                  Icons.search,
                                  size: 40,
                                  color: Color(0xFF11141C),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 15),
                                  // Adjust margin for spacing
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search for ‘AC service’',
                                      // Use hintText instead of labelText
                                      hintStyle: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 16,
                                      ),
                                      border: InputBorder
                                          .none, // Remove default border
                                      // You can customize other InputDecoration properties as needed
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
                          margin:
                              EdgeInsets.only(bottom: 11, left: 27, right: 27),
                          width: double.infinity,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 160,
                                  height: 160,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayProduct(uid: widget.uid,service :'ac'),
                                              ),
                                            );
                                          },
                                          child: Image.network(
                                            'https://imgs.search.brave.com/ND5t6Bnv2xK9Eoj4FA6ZFxEwmcNe09D3Hh9qOXo8efo/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTMw/ODM3NTI5NC9waG90/by90ZWNobmljaWFu/LXJlcGFpcmluZy1h/aXItY29uZGl0aW9u/ZXIuanBnP3M9NjEy/eDYxMiZ3PTAmaz0y/MCZjPUJaSWtKOXFh/ckQ2czk0dVdRYXVM/NHE4OEZ0NjVrcDd4/RU5zVUJNcklmalU9',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8), // Added space between the image and the text
                                      Text(
                                        'AC Sevice',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 160,
                                  height: 160,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayProduct(uid: widget.uid,service :'plumbing'),
                                              ),
                                            );
                                          },
                                          child: Image.network(
                                            'https://imgs.search.brave.com/U22BXcl5JChhE4To97idqGpTJ5q8p-brH-IAqKHs1vQ/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9zdC5k/ZXBvc2l0cGhvdG9z/LmNvbS8xMDEwNjEz/LzM5MTMvaS80NTAv/ZGVwb3NpdHBob3Rv/c18zOTEzMTg0NS1z/dG9jay1waG90by1w/bHVtYmVyLWZpdHRp/bmctc2luay1waXBl/LmpwZw',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8), // Added space between the image and the text
                                      Text(
                                        'Plumbing',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          margin:
                              EdgeInsets.only(bottom: 20, left: 27, right: 27),
                          width: double.infinity,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 160,
                                  height: 160,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayProduct(uid: widget.uid,service :'home'),
                                              ),
                                            );
                                          },
                                          child: Image.network(
                                            'https://www.online-cleaning-coach.com/wp-content/uploads/2020/03/i-1536x1024.jpg',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8), // Added space between the image and the text
                                      Text(
                                        'Cleaning',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 160,
                                  height: 160,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayProduct(uid: widget.uid,service :'painting'),
                                              ),
                                            );
                                          },
                                          child: Image.network(
                                            'https://imgs.search.brave.com/mKHCzbOKC_PbIr3EdxD5u8LBr_3c1CEHmJpI0arSt74/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMzLmRlcG9zaXRw/aG90b3MuY29tLzEw/MDM4MjcvMjU1L2kv/NDUwL2RlcG9zaXRw/aG90b3NfMjU1ODA3/MS1zdG9jay1waG90/by1ob3VzZS1wYWlu/dGVyLmpwZw',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8), // Added space between the image and the text
                                      Text(
                                        'Painting',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          margin:
                              EdgeInsets.only(bottom: 30, left: 28, right: 18),
                          width: double.infinity,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IntrinsicHeight(
                                  child: Text(
                                    'More to explore ',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Container(
                                    color: Color(0xFF999999),
                                    width: 217,
                                    child: SizedBox(),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: Color(0xFF22283A),
                          ),
                          padding: EdgeInsets.only(left: 13),
                          margin:
                              EdgeInsets.only(bottom: 46, left: 28, right: 28),
                          width: double.infinity,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Container(
                                    width: 85,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.only(top: 29),
                                            child: Text(
                                              'Native Smart \nProducts',
                                              style: TextStyle(
                                                color: Color(0xFFD9D9D9),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 192,
                                  height: 113,
                                  child: InkWell(
                                    onTap: () {
                                      // Add your action here, for example, navigate to another page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DisplayProduct(uid: widget.uid,service :'ac')),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://imgs.search.brave.com/wZLzdRLcZhXm_XGuL7V7kmZGU9byPjuhZ0l19XRLo9Q/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTAz/NjAwMzY1Mi9waG90/by9jYXJ3YXNoLXNl/cnZpY2UuanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPVN3dkRp/TVp2UDRWTmoyZDA4/b1hwV0tpMU9nZFNI/OEVVTDhET2FTRWhK/X1k9',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 17, left: 28, right: 28),
                        child: Text(
                          'Thoughtful curations',
                          style: TextStyle(
                            color: Color(0xFF6486FF),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          margin:
                              EdgeInsets.only(bottom: 33, left: 27, right: 27),
                          width: double.infinity,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(right: 8),
                                    width: 160,
                                    height: 254,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Add your action here, for example, navigate to another page
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplayProduct(uid: widget.uid,service :'ac')),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'https://imgs.search.brave.com/k4-LtnxT6nvLcD7lNWtyu0LtrQmWJDUN167dEC3KTSk/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9wbHVz/LnVuc3BsYXNoLmNv/bS9wcmVtaXVtX3Bo/b3RvLTE2Nzk1MDE5/NTYyMTUtMTE2OTI0/MThkYzQyP3E9ODAm/dz0xMDAwJmF1dG89/Zm9ybWF0JmZpdD1j/cm9wJml4bGliPXJi/LTQuMC4zJml4aWQ9/TTN3eE1qQTNmREI4/TUh4elpXRnlZMmg4/TVRkOGZHTnNaV0Z1/YVc1bmZHVnVmREI4/ZkRCOGZId3c.jpeg',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(right: 8),
                                      width: 160,
                                      height: 254,
                                      child: GestureDetector(
                                        onTap: () {
                                          // Add your action here, for example, navigate to another page
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayProduct(uid: widget.uid,service :'ac')),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            'https://imgs.search.brave.com/cQBQsuoouOXxG9l_cTQda7d7AqHKw1q2NH0EzG9vdW4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTAw/NzYwNzU3Mi9waG90/by9tYW4tcGFpbnRp/bmctaW50ZXJpb3It/b2YtaG9tZS1ieS13/aW5kb3cuanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPXgycnlO/bVpzRWRaVlBJRVEw/SHBXSFZvOTczdUpn/YTVkeTRLVTNpdmtk/dTQ9',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(right: 8),
                                      width: 160,
                                      height: 254,
                                      child: GestureDetector(
                                        onTap: () {
                                          // Add your action here, for example, navigate to another page
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DisplayProduct(uid: widget.uid,service :'ac')),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            'https://imgs.search.brave.com/oEEMk2w2Y3AzSptgOfPHlNNsqawHNoGWpt56EfAvZr0/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9mcm9udC12aWV3/LXBpbGUtbGF1bmRy/eV8yMy0yMTQ4Mzg3/MDAxLmpwZz9zaXpl/PTYyNiZleHQ9anBn',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 34, left: 16, right: 16),
                        child: Text(
                          'New and noteworthy',
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 24,
                          ),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          margin:
                              EdgeInsets.only(bottom: 9, left: 14, right: 14),
                          width: double.infinity,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(right: 10),
                                    width: 100,
                                    height: 100,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Add your action here, for example, navigate to another page
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplayProduct(uid: widget.uid,service :'ac')),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'https://imgs.search.brave.com/VphRqiheHMEg1wnY7DD_4XZT1ez_4b1TijTCtSCS2aw/rs:fit:500:0:0/g:ce/aHR0cHM6Ly93d3cu/dGhlc3BydWNlLmNv/bS90aG1iL3RXYldk/RnE5LTdpc2M5VHhL/NUQ5TjU3cGY0az0v/MTUwMHgwL2ZpbHRl/cnM6bm9fdXBzY2Fs/ZSgpOm1heF9ieXRl/cygxNTAwMDApOnN0/cmlwX2ljYygpL2hv/dy10by10b3VjaC11/cC1wYWludC01MTkz/ODM0LTA3LWZlMzg1/NGVlZjRjOTRiNDhi/MGY1ZmViZjE1NTY2/YmE1LmpwZw',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(right: 10),
                                    width: 100,
                                    height: 100,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Add your action here, for example, navigate to another page
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplayProduct(uid: widget.uid,service :'ac')),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'https://imgs.search.brave.com/zNPXFZNPWthVdVy6Ta1uOm_8m6p9zZ0Zcma6KyvQVyc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9j/YXJwZW50cnktY29u/Y2VwdC13aXRoLW1h/bl8yMy0yMTQ3Nzcz/MzMzLmpwZz9zaXpl/PTYyNiZleHQ9anBn',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(right: 10),
                                    width: 100,
                                    height: 100,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Add your action here, for example, navigate to another page
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplayProduct(uid: widget.uid,service :'ac')),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'https://imgs.search.brave.com/Qvfald_AQSN2fD7W_TXzan-e5D6tzaWsFXNKElkTh5U/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTEz/Njg1NTAxNi9waG90/by9ob3VzZWtlZXBp/bmctaG91c2UtY2xl/YW5pbmcuanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPXBudWgy/eU5BcElXWHBmMlcx/QkdtMnU0TVBkbWI3/T2dTNUdYRkZNTTZx/S009',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(right: 10),
                                    width: 100,
                                    height: 100,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Add your action here, for example, navigate to another page
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplayProduct(uid: widget.uid,service :'ac')),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'https://imgs.search.brave.com/J_G6R0h75BpAN1JOqI05APySdk00HdXhdjNZdFYe_AU/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9zdDQu/ZGVwb3NpdHBob3Rv/cy5jb20vMTMxOTM2/NTgvMjE3MDgvaS80/NTAvZGVwb3NpdHBo/b3Rvc18yMTcwODk2/OTgtc3RvY2stcGhv/dG8tY3JvcHBlZC1p/bWFnZS1lbGVjdHJp/Y2lhbi1jaGVja2lu/Zy1lbGVjdHJpY2Fs/LmpwZw',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}