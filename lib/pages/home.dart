// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:giga_store_/pages/catagory_products.dart';
import 'package:giga_store_/services/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:giga_store_/pages/onboarding.dart';
import 'package:giga_store_/widget/helping_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List catgories = [
    "images/laptop.png",
    "images/headphone_icon.png",
    "images/watch.png",
    "images/TV.png",
  ];

  List catagoryName = [
    "Laptop",
    "Headphones",
    'Watch',
    'TV',
  ];

  var queryResultSet = [];
  var tempSearchStore = [];

  String? name, image;

  getSharedPrefref() async {
    name = await SharedPreferencesHelper().getUserName();
    image = await SharedPreferencesHelper().getUserImage();
    setState(() {});
  }

  ontheLoad() async {
    await getSharedPrefref();
    setState(() {});
  }

  @override
  void initState() {
    ontheLoad();
    super.initState();
  }

//-------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecefe8),
      body: SingleChildScrollView(
        child: name == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hey, " + name!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            image!,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      //width: MediaQuery.of(context).size.width, child: TextField()
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Product",
                            hintStyle: AppWidget.lightTextFieldStyle(),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Catagories".text.black.xl2.bold.make(),
                        "See all".text.red600.xl.bold.make(),
                      ],
                    ),
                    20.heightBox,
                    Row(
                      children: [
                        Container(
                          height: 120,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: "All".text.white.xl.bold.make()),
                        ),
                        Expanded(
                          child: Container(
                            height: 120,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: catgories.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CatagoryTile(
                                    image: catgories[index],
                                    name: catagoryName[index],
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "All Products".text.black.xl2.bold.make(),
                        "See all".text.red600.xl.bold.make(),
                      ],
                    ),
                    20.heightBox,
                    Container(
                      height: 240,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Image.asset(
                                  "images/laptop2.png",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                "Laptop".text.bold.xl.make(),
                                10.heightBox,
                                Row(
                                  children: [
                                    "\$3000".text.red600.bold.xl.make(),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Image.asset(
                                  "images/headphone2.png",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                "Headphpne".text.bold.xl.make(),
                                10.heightBox,
                                Row(
                                  children: [
                                    "\$100".text.red600.bold.xl.make(),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Image.asset(
                                  "images/watch2.png",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                "Apple Watch".text.bold.xl.make(),
                                10.heightBox,
                                Row(
                                  children: [
                                    "\$500".text.red600.bold.xl.make(),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class CatagoryTile extends StatelessWidget {
  String image, name;
  CatagoryTile({
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CatagoryProducts(catagory: name)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 90,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}
