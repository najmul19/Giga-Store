// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:giga_store_/services/constant.dart';
import 'package:giga_store_/services/databse.dart';
import 'package:giga_store_/services/db_helper.dart';
import 'package:giga_store_/services/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetail extends StatefulWidget {
  String image, name, detail, price;
  ProductDetail({
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? name, email, image;
  getSharedPref() async {
    name = await SharedPreferencesHelper().getUserName();
    email = await SharedPreferencesHelper().getUserEmail();
    image = await SharedPreferencesHelper().getUserImage();
    setState(() {});
  }

  onLoad() async {
    await getSharedPref();
    setState(() {});
  }

  void initState() {
    super.initState();
    onLoad();
  }

  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfef5f1),
      body: Container(
        padding: EdgeInsets.only(
          top: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(30)),
                    child: Icon(Icons.arrow_back_ios_new_outlined)),
              ),

//firebase==================================================================================

              // Center(
              //   child: Image.network(
              //     widget.image!,
              //     height: 400,
              //   ),
              // )

//SQLite========================================================================

              Center(
                child: widget.image.startsWith('http') // Check if it's a URL
                    ? Image.network(
                        widget.image,
                        height: 400,
                        //fit: BoxFit.fill,
                      )
                    : Image.file(
                        File(widget.image), // Handle local file path
                        height: 400,
                        //fit: BoxFit.cover,
                      ),
              ),
            ]),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$" + widget.price,
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      20.heightBox,
                      "Details".text.bold.xl.make(),
                      10.heightBox,
                      Text(widget.detail),
                      70.heightBox,
                      InkWell(
                        onTap: () {
                          makePayment(widget.price);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: "Buy Now".text.white.bold.xl.make()),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String ammount) async {
    try {
      paymentIntent = await creatPaymentIntent(ammount, 'USD');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent?['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: "Najmul"))
          .then((value) {});

      displayPaymentSheet();
    } catch (e, s) {
      print('Exception during payment:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        Map<String, dynamic> orderInfoMap = {
         // "Product": widget.name,
          "name": widget.name,       // Column name in SQLite table
        "price": widget.price,     // Column price in SQLite table
        "category": email,         // Use category for email association
        "image": widget.image,     // Column image in SQLite table
        "detail": widget.detail,   // Column detail in SQLite table
        // "status": "Pending"
       };

       // await Databse().orderDetails(orderInfoMap);
        // Save to SQLite
      final dbHelper = DBHelper();
      await dbHelper.insertProduct(orderInfoMap);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull")
                        ],
                      )
                    ],
                  ),
                ));
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print("Error is :---> $error $StackTrace");
      });
    } on StripeException catch (e) {
      print("Error is:---> $e");
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled"),
              ));
    } catch (e) {
      print("$e");
    }
  }

  Future<Map<String, dynamic>> creatPaymentIntent(
      String amount, String currency) async {
    try {
      final body = {
        'amount': (int.parse(amount) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey', // Ensure this is correct
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('Error creating Payment Intent: $err');
      rethrow;
    }
  }

  calculateAmmount(String ammount) {
    final calculatedAmmount = {int.parse(ammount) * 100};
    return calculatedAmmount.toString();
  }
}
