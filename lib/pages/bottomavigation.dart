import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:giga_store_/pages/home.dart';
import 'package:giga_store_/pages/order.dart';
import 'package:giga_store_/pages/profile.dart';

class Bottomavigation extends StatefulWidget {
  const Bottomavigation({super.key});

  @override
  State<Bottomavigation> createState() => _BottomavigationState();
}

class _BottomavigationState extends State<Bottomavigation> {
  late List<Widget> pages;
  late Home home;
  late Order order;
  late Profile profile;
  int currentTabIndex = 0;
  @override
  void initState() {
    home = Home();
    order = Order();
    profile = Profile();
    pages = [home, order, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Color(0xffecefe8),
          color: Colors.black,
          animationDuration: Duration(microseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.person_2_outlined,
              color: Colors.white,
            ),
          ]),
      body: pages[currentTabIndex],
    );
  }
}
