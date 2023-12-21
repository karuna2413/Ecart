import 'package:flutter/material.dart';
import 'package:mangoit_ecart/pages/Catelog_Screen.dart';
import 'package:mangoit_ecart/pages/MyBag.dart';
import 'package:mangoit_ecart/pages/Myprofile.dart';
import 'package:mangoit_ecart/widgets/ProductCard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var selectedTab = 0;

  void onBottomTab(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Widget content = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Stack(
              children: [
                ClipRRect(
                  child: Image.asset('assets/banner2.jpg'),
                ),
                const Positioned(
                    left: 20,
                    bottom: 10,
                    child: Text(
                      'Street clothes',
                      style: TextStyle(fontSize: 34, color: Colors.white),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Sale',
                      style: TextStyle(fontSize: 34),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedTab = 1;
                      });
                    },
                    child: Text(
                      'View all',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Super summer sale',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ProductCard(
                        value: '50%', color: Colors.yellow.shade800),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'New',
                      style: TextStyle(fontSize: 34),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedTab = 1;
                      });
                    },
                    child: Text(
                      'View all',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'You have never seen it before!',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ProductCard(value: 'new', color: Colors.black),
                  )),
            ],
          )
        ],
      ),
    );

    if (selectedTab == 1) {
      content = CatelogScreen();
    }
    if (selectedTab == 2) {
      content = MyBag();
    }

    if (selectedTab == 3) {
      content = const MyProfile();
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
        body: content,
        bottomNavigationBar: Container(
          height: 60,
          width: width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.yellow.shade800,
              selectedLabelStyle: const TextStyle(fontSize: 11),
              unselectedItemColor: const Color.fromRGBO(218, 218, 218, 1),
              showUnselectedLabels: true,
              unselectedLabelStyle: const TextStyle(fontSize: 11),
              currentIndex: selectedTab,
              onTap: onBottomTab,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 30,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                    ),
                    label: 'Shop'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      size: 30,
                    ),
                    label: 'Bag'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_outline,
                      size: 30,
                    ),
                    label: 'Profile'),
              ]),
        ),
      ),
    );
  }
}
