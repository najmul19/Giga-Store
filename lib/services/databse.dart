import 'package:cloud_firestore/cloud_firestore.dart';

class Databse {
  Future addUserDetails(Map<String, dynamic> userInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfo);
  }

  Future addProducts(Map<String, dynamic> userInfo) async {
    return await FirebaseFirestore.instance
        .collection("Products")
       
        .add(userInfo);
  }

  Future addProduct(Map<String, dynamic> userInfo, String catagoryname) async {
    return await FirebaseFirestore.instance
        .collection(catagoryname)
        .add(userInfo);
  }

  Future<Stream<QuerySnapshot>> getProducts(String catagory) async {
    return await FirebaseFirestore.instance.collection(catagory).snapshots();
  }

  Future<Stream<QuerySnapshot>> getOrders(String email) async {
    return await FirebaseFirestore.instance.collection("Orders").where("Email",isEqualTo: email).snapshots();
  }


   Future orderDetails(Map<String, dynamic> userInfo) async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        
        .add(userInfo);
  }
}
