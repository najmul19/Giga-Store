// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:giga_store_/pages/product_detail.dart';
// import 'package:giga_store_/services/databse.dart';
// import 'package:giga_store_/services/db_helper.dart';
// import 'package:velocity_x/velocity_x.dart';

// class CatagoryProducts extends StatefulWidget {
//   String catagory;
//   CatagoryProducts({
//     required this.catagory,
//   });

//   @override
//   State<CatagoryProducts> createState() => _CatagoryProductsState();
// }

// class _CatagoryProductsState extends State<CatagoryProducts> {
//   // Stream? CatagoryStream;
//   // getOnTheLoad() async {
//   //   CatagoryStream = await Databse().getProducts(widget.catagory);
//   //   setState(() {});
//   // }

//   List<Map<String, dynamic>> categoryProducts = [];

// //Sqlite============================================
//   // getOnTheLoad() async {
//   //   final dbHelper = DBHelper();
//   //   final db = await dbHelper.db;
//   //   categoryProducts = await db.query(
//   //     'products',
//   //     where: 'category = ?',
//   //     whereArgs: [widget.catagory],
//   //   );

//   //   ///update for order page
//   //   for (var product in categoryProducts) {
//   //   debugPrint("Product: ${product.toString()}");
//   // }
//   //   setState(() {});
//   // }

//   //Updated SQLite

//   getOnTheLoad() async {
//     final dbHelper = DBHelper();
//     final db = await dbHelper.db;
//     final List<Map<String, dynamic>> queryResult = await db.query(
//       'products',
//       where: 'category = ?',
//       whereArgs: [widget.catagory],
//     );

//     // Ensure the list is modifiable
//     categoryProducts = List<Map<String, dynamic>>.from(queryResult);

//     for (var product in categoryProducts) {
//       debugPrint("Product: ${product.toString()}");
//     }

//     setState(() {});
//   }

//   @override
//   void initState() {
//     getOnTheLoad();
//     super.initState();
//   }

//   // Widget allProducts() {
//   //   return StreamBuilder(
//   //       stream: CatagoryStream,
//   //       builder: (context, AsyncSnapshot snapshot) {
//   //         return snapshot.hasData
//   //             ? GridView.builder(
//   //                 padding: EdgeInsets.zero,
//   //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//   //                     crossAxisCount: 2,
//   //                     childAspectRatio: 0.6,
//   //                     mainAxisSpacing: 10,
//   //                     crossAxisSpacing: 10),
//   //                 itemCount: snapshot.data.docs.length,
//   //                 itemBuilder: (context, index) {
//   //                   DocumentSnapshot ds = snapshot.data.docs[index];

//   //                   return Container(
//   //                     padding:
//   //                         EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   //                     decoration: BoxDecoration(
//   //                         color: Colors.white,
//   //                         borderRadius: BorderRadius.circular(10)),
//   //                     child: Column(
//   //                       children: [
//   //                         10.heightBox,
//   //                         Image.network(
//   //                           ds["Image"],
//   //                           height: 150,
//   //                           width: 150,
//   //                           fit: BoxFit.cover,
//   //                         ),
//   //                         10.heightBox,
//   //                         ds["Name"].text.bold.xl.make(),
//   //                         Spacer(),
//   //                         Row(
//   //                           children: [
//   //                             Text(
//   //                               "\$" + ds["Price"],
//   //                               style: TextStyle(
//   //                                 color: Colors.redAccent,
//   //                                 fontSize: 22,
//   //                                 fontWeight: FontWeight.bold,
//   //                               ),
//   //                             ),
//   //                             SizedBox(
//   //                               width: 30,
//   //                             ),
//   //                             InkWell(
//   //                               onTap: () {
//   //                                 Navigator.push(
//   //                                     context,
//   //                                     MaterialPageRoute(
//   //                                         builder: (context) => ProductDetail(
//   //                                             image: ds["Image"],
//   //                                             name: ds["Name"],
//   //                                             detail: ds["Detail"],
//   //                                             price: ds["Price"])));
//   //                               },
//   //                               child: Container(
//   //                                   padding: EdgeInsets.all(5),
//   //                                   decoration: BoxDecoration(
//   //                                       color: Colors.redAccent,
//   //                                       borderRadius: BorderRadius.circular(7)),
//   //                                   child: Icon(
//   //                                     Icons.add,
//   //                                     color: Colors.white,
//   //                                   )),
//   //                             )
//   //                           ],
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   );
//   //                 })
//   //             : Container();
//   //       });
//   // }

//   //Sqlite=======================================

//   // Widget allProducts() {
//   //   return categoryProducts.isNotEmpty
//   //       ? GridView.builder(
//   //           padding: EdgeInsets.zero,
//   //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//   //               crossAxisCount: 2,
//   //               childAspectRatio: 0.6,
//   //               mainAxisSpacing: 10,
//   //               crossAxisSpacing: 10),
//   //           itemCount: categoryProducts.length,
//   //           itemBuilder: (context, index) {
//   //             final product = categoryProducts[index];

//   //           //   // Clean up the image path (updat for order)=============================================================
//   //           // // Sanitize the image path
//   //           // final imagePath = product["image"];
//   //           // final sanitizedPath = imagePath?.startsWith('file://')
//   //           //     ? imagePath.replaceFirst('file://', '')
//   //           //     : imagePath;

//   //           // // Handle invalid paths or missing files
//   //           // Widget imageWidget;
//   //           // if (sanitizedPath != null && File(sanitizedPath).existsSync()) {
//   //           //   imageWidget = Image.file(
//   //           //     File(sanitizedPath),
//   //           //     height: 150,
//   //           //     width: 150,
//   //           //     fit: BoxFit.cover,
//   //           //   );
//   //           // } else {
//   //           //   imageWidget = Image.asset(
//   //           //     'images/watch.png', // Placeholder image
//   //           //     height: 150,
//   //           //     width: 150,
//   //           //     fit: BoxFit.cover,
//   //           //   );
//   //           // }//========================================================================================update for order

//   //             return Container(
//   //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//   //               decoration: BoxDecoration(
//   //                   color: Colors.white,
//   //                   borderRadius: BorderRadius.circular(10)),
//   //               child: Column(
//   //                 children: [
//   //                   10.heightBox,
//   //                   Image.file(
//   //                     File(product["image"]),
//   //                     height: 150,
//   //                     width: 150,
//   //                     fit: BoxFit.cover,
//   //                   ),
//   //                   10.heightBox,
//   //                   product["name"].toString().text.bold.xl.make(),
//   //                   Spacer(),
//   //                   Row(
//   //                     children: [
//   //                       Text(
//   //                         "\$${product["price"]}",
//   //                         style: TextStyle(
//   //                           color: Colors.redAccent,
//   //                           fontSize: 22,
//   //                           fontWeight: FontWeight.bold,
//   //                         ),
//   //                       ),
//   //                       SizedBox(
//   //                         width: 22,
//   //                       ),
//   //                       InkWell(
//   //                         onTap: () {
//   //                           Navigator.push(
//   //                               context,
//   //                               MaterialPageRoute(
//   //                                   builder: (context) => ProductDetail(
//   //                                       image: product["image"],
//   //                                       name: product["name"],
//   //                                       detail: product["detail"],
//   //                                       price: product["price"].toString())));
//   //                         },
//   //                         child: Container(
//   //                             padding: EdgeInsets.all(5),
//   //                             decoration: BoxDecoration(
//   //                                 color: Colors.redAccent,
//   //                                 borderRadius: BorderRadius.circular(7)),
//   //                             child: Icon(
//   //                               Icons.add,
//   //                               color: Colors.white,
//   //                             )),
//   //                       )
//   //                     ],
//   //                   ),
//   //                 ],
//   //               ),
//   //             );
//   //           })
//   //       : Center(child: "No products available.".text.xl.make());
//   // }

//   //Updated SQLite->---------------------------------------------------------------------------------

//   Widget allProducts() {
//     return categoryProducts.isNotEmpty
//         ? GridView.builder(
//             padding: EdgeInsets.zero,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.6,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10),
//             itemCount: categoryProducts.length,
//             itemBuilder: (context, index) {
//               final product = categoryProducts[index];

//               return GestureDetector(
//                 onLongPress: () async {
//                   // Show confirmation dialog
//                   final shouldDelete = await showDialog<bool>(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text("Delete Product"),
//                         content: Text(
//                             "Are you sure you want to delete this product?"),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, false),
//                             child: Text("No"),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, true),
//                             child: Text("Yes"),
//                           ),
//                         ],
//                       );
//                     },
//                   );

//                   // If user confirmed, delete the product
//                   if (shouldDelete ?? false) {
//                     final dbHelper = DBHelper();
//                     final db = await dbHelper.db;

//                     await db.delete(
//                       'products',
//                       where: 'id = ?',
//                       whereArgs: [product['id']],
//                     );

//                     // Refresh the product list
//                     categoryProducts.removeAt(index);
//                     setState(() {});
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Column(
//                     children: [
//                       10.heightBox,
//                       Image.file(
//                         File(product["image"]),
//                         height: 150,
//                         width: 150,
//                         fit: BoxFit.cover,
//                       ),
//                       10.heightBox,
//                       product["name"].toString().text.bold.xl.make(),
//                       Spacer(),
//                       Row(
//                         children: [
//                           Text(
//                             "\$${product["price"]}",
//                             style: TextStyle(
//                               color: Colors.redAccent,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 22,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => DetailsPage(
//                                           image: product["image"],
//                                           name: product["name"],
//                                           detail: product["detail"],
//                                           price: product["price"].toString())));
//                             },
//                             child: Container(
//                                 padding: EdgeInsets.all(5),
//                                 decoration: BoxDecoration(
//                                     color: Colors.redAccent,
//                                     borderRadius: BorderRadius.circular(7)),
//                                 child: Icon(
//                                   Icons.add,
//                                   color: Colors.white,
//                                 )),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             })
//         : Center(child: "No products available.".text.xl.make());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffecefe8),
//       appBar: AppBar(
//         backgroundColor: Color(0xffecefe8),
//       ),
//       body: Container(
//         margin: EdgeInsets.only(left: 20, right: 20),
//         child: Column(
//           children: [
//             Expanded(child: allProducts()),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:io';

import '../services/db_helper.dart';
import 'product_detail.dart'; // Import your ProductDetail page

class CategoryProducts extends StatefulWidget {
  final String catagory,email;


  const CategoryProducts({required this.catagory, super.key, required this.email});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  List categoryProducts = []; // Store fetched category products here

  @override
  void initState() {
    super.initState();
    _fetchCategoryProducts(); // Fetch category products when the widget initializes
  }

  Future<void> _fetchCategoryProducts() async {
    final dbHelper = DBHelper(); // Create instance of DBHelper
    try {
      final data = await dbHelper.db.then(
          (db) => db.query('products', where: 'category = ?', whereArgs: [widget.catagory])); // Query products by category
      if (data.isNotEmpty) {
        debugPrint("Fetched category products: $data"); // Log fetched data
        setState(() {
          categoryProducts = data; // Assign fetched data to categoryProducts
        });
      } else {
        debugPrint("No products found for the category ${widget.catagory}.");
      }
    } catch (e) {
      debugPrint("Error fetching category products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 49, 82, 97),
        title: Text("${widget.catagory} Products"),
      ),
      backgroundColor: const Color(0xffecefe8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              categoryProducts.isEmpty
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
                      itemCount: categoryProducts.length,
                      itemBuilder: (context, index) {
                        final product = categoryProducts[index];
                        return ProductTile(
                            name: product['name'] ?? 'Unknown',
                            image: product['image'] ?? '',
                            price: product['price'] ?? '0',
                            detail: product['detail'] ?? 'No details',
                            email:widget.email,
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


class ProductTile extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String detail,email;

  const ProductTile({
    required this.name,
    required this.image,
    required this.price,
    required this.detail, required this.email,
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
