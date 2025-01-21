import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:giga_store_/pages/home.dart';
import 'package:giga_store_/pages/my_orders.dart';

import 'package:giga_store_/pages/profile.dart';

class Bottomavigation extends StatefulWidget {
  final String userName;
  final String userImage;
  final String userEmail;

  const Bottomavigation({
    super.key,
    required this.userName,
    required this.userImage,
    required this.userEmail,
  });

  @override
  State<Bottomavigation> createState() => _BottomavigationState();
}

class _BottomavigationState extends State<Bottomavigation> {
  late List<Widget> pages;
  late Home home;
  late MyOrdersPage myOrdersPage;
  late Profile profile;
  int currentTabIndex = 0;
  @override
  void initState() {
    home = Home(
      name: widget.userName,
      image: widget.userImage,
      email: widget.userEmail,
    );

    myOrdersPage = MyOrdersPage(userEmail: widget.userEmail);
    profile = Profile(
      email: widget.userEmail,
      name: widget.userName,
    );
    pages = [home, myOrdersPage, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Color(0xffecefe8),
          color: const Color.fromARGB(255, 49, 82, 97),
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
