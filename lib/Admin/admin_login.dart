import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giga_store_/Admin/home_admin.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController userNameController = new TextEditingController();
  TextEditingController userPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Admin Pannel'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/sign_up.png",
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Name Field
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Username",
                      labelText: "Username",
                      // border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_2_outlined),
                    ),
                  ),
                ),
                16.heightBox,

                // Password Field
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    obscureText: true,
                    controller: userPasswordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Password",
                      labelText: "Password",
                      // border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                16.heightBox,

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      loginAdmin();
                    },
                    child: Text('Login'),
                  ),
                ),
                16.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginAdmin() async {
    bool isAuthenticated = false; // Track if admin is authenticated

    await FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      for (var result in snapshot.docs) {
        if (result.data()['username'] == userNameController.text.trim() &&
            result.data()['password'] == userPasswordController.text.trim()) {
          isAuthenticated = true;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeAdmin()));
          break; // Stop checking further once authenticated
        }
      }
    });

    // If not authenticated, show error message
    if (!isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: "Invalid username or password".text.xl.make(),
      ));
    }
  }
}
