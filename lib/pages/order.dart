import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giga_store_/Admin/add_product.dart';
import 'package:giga_store_/services/databse.dart';
import 'package:giga_store_/services/db_helper.dart';
import 'package:giga_store_/services/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? email;

  // SQLite=========
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;
  // ===================

  // Fetch user email from shared preferences
  getSharedPrefref() async {
    email = await SharedPreferencesHelper().getUserEmail();
    setState(() {});
  }

  // Fetch products from SQLite based on the email (if applicable) =======================================
  getProducts() async {
    await getSharedPrefref();
    final dbHelper = DBHelper();
    // Fetch all products (or filter by user email if needed)
    final dbClient = await dbHelper.db;
    products = await dbClient.query(
      'products',
      where: 'category = ?', // Adjust this based on your schema
      whereArgs: [email], // Remove whereArgs if no email filter is needed
    );
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProducts(); // Load products on initialization
  }
// ====================================================================================

  // Firebase=========================================================================

  // Stream? orderStream;

  // getOnLoad() async {
  //   await getSharedPrefref();
  //   orderStream = await Databse().getOrders(email!);
  //   setState(() {});
  // }

  // void initState() {
  //   getOnLoad();
  //   super.initState();
  // }

  // Widget allOrders() {
  //   return StreamBuilder(
  //       stream: orderStream,
  //       builder: (context, AsyncSnapshot snapshot) {
  //         return snapshot.hasData
  //             ? ListView.builder(
  //                 padding: EdgeInsets.zero,
  //                 itemCount: snapshot.data.docs.length,
  //                 itemBuilder: (context, index) {
  //                   DocumentSnapshot ds = snapshot.data.docs[index];

  //                   return Material(
  //                     elevation: 3.0,
  //                     borderRadius: BorderRadius.circular(10),
  //                     child: Container(
  //                       padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
  //                       width: MediaQuery.of(context).size.width,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         color: Colors.white,
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           Image.network(
  //                             ds["ProductImage"],
  //                             height: 120,
  //                             width: 120,
  //                             fit: BoxFit.cover,
  //                           ),
  //                           SizedBox(
  //                             width: 20,
  //                           ),
  //                           Column(
  //                             children: [
  //                               ds["Product"].toString().text.xl.bold.black.make(),
  //                               Text(
  //                                 "\$" + ds["Price"].toString(),
  //                                 style: TextStyle(
  //                                   color: Colors.redAccent,
  //                                   fontSize: 23,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 })
  //             : Container();
  //       });
  // }

  // Widget to display the products SQLite============================================================================
  Widget allOrders() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return products.isNotEmpty
        ? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        product["image"].startsWith("http") // Handle image type
                            ? Image.network(
                                product["image"],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(product["image"]),
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            product["name"]
                                .toString()
                                .text
                                .xl
                                .bold
                                .black
                                .make(),
                            Text(
                              "\$" + product["price"].toString(),
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Status: ${product["status"] ?? "Pending"}",
                              style: TextStyle(
                                color: product["status"] == "Completed"
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Center(child: Text("No orders found"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "Current Order".text.xl2.bold.black.make(),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Expanded(child: allOrders()),
          ],
        ),
      ),
    );
  }
}
