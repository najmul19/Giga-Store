import 'package:flutter/material.dart';
import 'dart:io';

import '../services/db_helper.dart';
import 'cart.dart';
import 'my_orders.dart';

class DetailsPage extends StatefulWidget {
  final String name;
  final String image;
  final String price;
  final String detail;
  final String email;

  const DetailsPage({
    required this.name,
    required this.image,
    required this.price,
    required this.detail,
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
   int quantity = 1;
  Future<void> _placeOrder(BuildContext context) async {
    final dbHelper = DBHelper();

    // Insert order into database
    await dbHelper.insertOrder({
      'product_id':
          1, // Replace with actual product ID from context or elsewhere
      'user_email': widget.email,
      'product_name': widget.name,
      // 'test@example.com', // Replace with the logged-in user's email
      'quantity': quantity, // Replace with selected quantity from QuantitySelector
      'total_price': (int.parse(widget.price) * quantity)
          .toString(), // Replace with total price calculation logic
      'date': DateTime.now().toIso8601String(), // Current date
    });

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order placed successfully!")),
    );
  }

  Future<void> _addToCart(BuildContext context) async {
    final dbHelper = DBHelper();

    // Insert product into cart database
    await dbHelper.insertCart({
      'name': widget.name,
      'image': widget.image,
      'price': widget.price,
      'quantity':quantity,
      'detail': widget.detail,
      'category': 'Cart', // Example category
      'status': 'In Cart', // Example status
      'user_email': widget.email
      //'test@example.com', // Replace with actual user email
    });

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added to cart!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        backgroundColor: const Color(0xFF315261),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt), // My Orders icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyOrdersPage(userEmail: widget.email),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: File(widget.image).existsSync()
                      ? Image.file(
                          File(widget.image),
                          height: 250,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : const Center(child: Text('No Image')),
                ),
              ),
              const SizedBox(height: 20),
              // Name and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${widget.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Details Section
              Text(
                "Details:",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.detail,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              // Quantity Selector
              Row(
                children: [
                  const Text(
                    "Quantity:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  QuantitySelector(
                    quantity: quantity, // Pass the current quantity
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        quantity = newQuantity; // Update the quantity
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _addToCart(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("Add to Cart"),
                  ),
                  ElevatedButton(
                    onPressed: () => _placeOrder(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Place Order"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage(email: widget.email, quantity: quantity,price: widget.price, productName: widget.name,)),
          );
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Function(int) onQuantityChanged;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (quantity > 1) {
              onQuantityChanged(quantity - 1);
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Text(
          "$quantity",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {
            onQuantityChanged(quantity + 1);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
