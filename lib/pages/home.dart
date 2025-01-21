// import 'package:flutter/material.dart';
// import 'package:giga_store_/pages/catagory_products.dart';

// import 'package:velocity_x/velocity_x.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../services/db_helper.dart';
import 'catagory_products.dart';
import 'product_detail.dart'; // Import your CatagoryProducts page

class Home extends StatefulWidget {
  final String name;
  final String image;
  final String email;

  const Home(
      {required this.name,
      required this.image,
      super.key,
      required this.email});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "images/laptop.png",
    "images/headphone_icon.png",
    "images/watch.png",
    "images/TV.png",
  ];

  List categoryName = [
    "Laptop",
    "Headphones",
    'Watch',
    'TV',
  ];

  List allProducts = []; // Store fetched products here

  @override
  void initState() {
    super.initState();
    _fetchAllProducts(); // Fetch products when the widget initializes
  }

  Future<void> _fetchAllProducts() async {
    final dbHelper = DBHelper(); // Create instance of DBHelper
    try {
      final data = await dbHelper.db
          .then((db) => db.query('products')); // Query products
      if (data.isNotEmpty) {
        debugPrint("Fetched products: $data"); // Log fetched data
        setState(() {
          allProducts = data; // Assign fetched data to allProducts
        });
      } else {
        debugPrint("No products found in the database.");
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 49, 82, 97),
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hey, ${widget.name}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Welcome",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: widget.image.startsWith('http')
                          ? Image.network(
                              widget.image,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              widget.image,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Name",
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xffecefe8),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories Section
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Categories".text.black.xl2.bold.make(),
                  // "See all".text.red600.xl.bold.make(),
                ],
              ),
              20.heightBox,
              Row(
                children: [
                  Container(
                    height: 120,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(right: 20),
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
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              image: categories[index],
                              name: categoryName[index],
                              email: widget.email,
                            );
                          }),
                    ),
                  ),
                ],
              ),
              20.heightBox,
              // All Products Section
              "All Products".text.black.xl2.bold.make(),
              20.heightBox,
              allProducts.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10, // Spacing between columns
                        mainAxisSpacing: 10, // Spacing between rows
                        childAspectRatio: 0.7, // Aspect ratio for each item
                      ),
                      itemCount: allProducts.length,
                      itemBuilder: (context, index) {
                        final product = allProducts[index];
                        return ProductTile(
                          name: product['name'] ?? 'Unknown',
                          image: product['image'] ?? '',
                          price: product['price'] ?? '0',
                          detail: product['detail'] ?? 'No details',
                          email: widget.email,
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image, name, email;

  const CategoryTile({
    required this.image,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProducts(
              catagory: name,
              email: email,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(right: 20),
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
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String detail;
  final String email;

  const ProductTile({
    required this.name,
    required this.image,
    required this.price,
    required this.detail,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              name: name,
              image: image,
              price: price,
              detail: detail,
              email: email,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: File(image).existsSync()
                    ? Image.file(
                        File(image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : const Center(child: Text('No Image')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "\$${price}",
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
