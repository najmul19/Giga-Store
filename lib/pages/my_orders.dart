import 'package:flutter/material.dart';

import '../services/db_helper.dart';

class MyOrdersPage extends StatefulWidget {
  final String userEmail;

  const MyOrdersPage({required this.userEmail, Key? key}) : super(key: key);

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  late Future<List<Map<String, dynamic>>> orders;

  @override
  void initState() {
    super.initState();
    orders = DBHelper().fetchOrders(widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: const Color(0xFF315261),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading orders"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No orders found"));
          }

          final ordersList = snapshot.data!;
          return ListView.builder(
            itemCount: ordersList.length,
            itemBuilder: (context, index) {
              final order = ordersList[index];
              return OrderTile(
                order: order,
                email: widget.userEmail,
              );
            },
          );
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final Map<String, dynamic> order;
  final String email;

  const OrderTile({required this.order, Key? key, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Email: " + email,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text("Product Name: ${order['product_name']}"),
            Text("Product ID: ${order['product_id']}"),
            Text("Quantity: ${order['quantity']}"),
            Text("Total Price: \$${order['total_price']}"),
            Text("Date: ${order['date']}"),
          ],
        ),
      ),
    );
  }
}
