import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:giga_store_/services/databse.dart';
import 'package:giga_store_/services/db_helper.dart';
import 'package:giga_store_/widget/helping_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? value;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController detailController = new TextEditingController();
  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  // uploadItem() async {
  //   if (selectedImage != null && nameController.text != "") {
  //     String addId = randomAlphaNumeric(10);
  //     Reference firebaseStorageRef =
  //         FirebaseStorage.instance.ref().child("allImages").child(addId);
  //     final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
  //     var DownloadTask = (await task).ref.getDownloadURL();
  //     Map<String, dynamic> addProduct = {
  //       "Name": nameController.text,
  //       "Image": DownloadTask,
  //       "Price": priceController.text,
  //       "Detail": detailController.text,
  //     };
  //     await Databse().addProduct(addProduct, value!).then((value) {
  //       selectedImage = null;
  //       nameController.text = "";
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         backgroundColor: Colors.redAccent,
  //         content: "Product has been uploaded succesfully!!!".text.xl2.make(),
  //       ));
  //     });
  //   }
  // }

  //sqlite=================================================

  uploadItem() async {
    if (selectedImage != null && nameController.text.isNotEmpty) {
      String imagePath = selectedImage!.path; // Store file path
     
      Map<String, dynamic> addProduct = {
        "name": nameController.text,
        "image": imagePath,
        "price": priceController.text,
    
        "detail": detailController.text,
        "category": value ?? '',
      };

      await DBHelper().insertProduct(addProduct);

      selectedImage = null;
      nameController.clear();
      priceController.clear();
      detailController.clear();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: "Product has been added successfully!".text.make(),
      ));
    }
  }

  final List<String> catagoryItems = ['Watch', 'Laptop', 'TV', 'Headphones'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
        title: "Add Product".text.bold.xl.make(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Upload the Product Image".text.gray500.xl.make(),
              20.heightBox,
              selectedImage == null
                  ? InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
              20.heightBox,
              "Product Name".text.xl.gray500.make(),
              20.heightBox,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(18)),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              20.heightBox,
              "Product Price".text.xl.gray500.make(),
              20.heightBox,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(18)),
                child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              20.heightBox,
              "Product Details".text.xl.gray500.make(),
              20.heightBox,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(18)),
                child: TextField(
                  maxLines: 6,
                  controller: detailController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              20.heightBox,
              "Product Catagory".text.xl.gray500.make(),
              20.heightBox,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: catagoryItems
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )))
                        .toList(),
                    onChanged: (value) => setState(() {
                      this.value = value;
                    }),
                    dropdownColor: Colors.white,
                    hint: "Select Catagory".text.make(),
                    iconSize: 36,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: value,
                  ),
                ),
              ),
              30.heightBox,
              ElevatedButton(
                onPressed: () {
                  uploadItem();
                },
                child: Center(child: "Add Product".text.xl2.make()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
