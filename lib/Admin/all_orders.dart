import 'dart:io';
import 'package:flutter/material.dart';
import 'package:giga_store_/services/db_helper.dart';
import 'package:giga_store_/services/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key? key}) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  String? email;
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;

  // Fetch user email from shared preferences (or Firebase auth)
  Future<void> getUserEmail() async {
    email = await SharedPreferencesHelper().getUserEmail();
    setState(() {});
  }

  // Fetch orders from SQLite
  Future<void> fetchOrders() async {
    await getUserEmail();
    if (email != null) {
      final dbHelper = DBHelper();
      final dbClient = await dbHelper.db;
      products = await dbClient.query(
        'products',
        where: 'user_email = ?', // Fetch orders for the logged-in user
        whereArgs: [email],
      );
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Widget allOrders() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return products.isNotEmpty
        ? ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        // Display product image (from URL or local file)
                        product["image"].startsWith("http")
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
                        const SizedBox(width: 20),
                        // Display product details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            product["name"].toString().text.xl.bold.black.make(),
                            "\$${product["price"]}"
                                .text
                                .red500
                                .xl2
                                .bold
                                .make(),
                            email != null
    ? email!.text.sm.gray500.italic.make() // If email is not null, display it
    : "No email available".text.sm.gray500.italic.make(), // Fallback if email is null

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(child: Text("No orders found"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "All Orders".text.xl2.bold.black.make(),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: allOrders(),
      ),
    );
  }
}
