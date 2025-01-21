import 'package:flutter/material.dart';
import 'dart:io';
import '../services/db_helper.dart';

class CartPage extends StatelessWidget {
  final String email, price, productName;
  final int quantity;

  const CartPage(
      {Key? key,
      required this.email,
      required this.quantity,
      required this.price,
      required this.productName})
      : super(key: key);

  Future<List<Map<String, dynamic>>> _fetchCartItems() async {
    final dbHelper = DBHelper();
    return await dbHelper.db.then((db) => db.query(
          'cart',
          where: 'category = ?',
          whereArgs: ['Cart'],
        ));
  }

  Future<void> _placeOrder(BuildContext context) async {
    final dbHelper = DBHelper();
    final cartItems = await _fetchCartItems();

    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your cart is empty!")),
      );
      return;
    }

    double totalPrice = 0;
    int len = 0;
    for (var item in cartItems) {
      double pricePerItem = double.parse(item['price']);
      int itemQuantity = int.parse(item['quantity'].toString());
      len += itemQuantity;
      totalPrice += (pricePerItem * itemQuantity);

      // totalPrice += double.parse(item['price']);
    }

    await dbHelper.insertOrder({
      'product_id': 1,
      'product_name': productName,
      'user_email': email,
      'quantity': len,
      'total_price': (totalPrice).toString(),
      'date': DateTime.now().toIso8601String(),
    });

    await dbHelper.db.then((db) => db.delete(
          'cart',
          where: 'category = ?',
          whereArgs: ['Cart'],
        ));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order placed successfully!")),
    );

    Navigator.pop(context);
  }

  Future<void> _removeItemFromCart(int id) async {
    final dbHelper = DBHelper();
    await dbHelper.db.then((db) => db.delete(
          'cart',
          where: 'id = ?',
          whereArgs: [id],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffecefe8),
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: const Color(0xFF315261),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(child: Text("Your cart is empty!"));
          }

          final cartItems = snapshot.data!;
          double totalPrice = 0;

          for (var item in cartItems) {
            double pricePerItem = double.parse(item['price']);
            int itemQuantity = int.parse(item['quantity'].toString());
            totalPrice += (pricePerItem * itemQuantity);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    double pricePerItem = double.parse(item['price']);
                    int itemQuantity = int.parse(item['quantity'].toString());

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: File(item['image']).existsSync()
                            ? Image.file(File(item['image']),
                                width: 50, height: 50, fit: BoxFit.cover)
                            : const Icon(Icons.image_not_supported),
                        title: Text(item['name'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Quantity: $itemQuantity",
                                style: TextStyle(color: Colors.grey)),
                            Text(
                                "Total: \$${(pricePerItem * itemQuantity).toStringAsFixed(2)}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeItemFromCart(item['id']),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Total Price: \$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => _placeOrder(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child:
                      const Text("Place Order", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
