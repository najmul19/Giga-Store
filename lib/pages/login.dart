// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:giga_store_/pages/bottomavigation.dart';
import 'package:giga_store_/pages/home.dart';
import 'package:giga_store_/pages/sign_up.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool changeBtn = false;

  String? email, password;

  login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Bottomavigation()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: "No User Found for that Email".text.xl2.make(),
          ));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: "Wrong Password Provided by the user".text.xl2.make(),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: "Login".text.bold.xl2.black.make(),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              children: [
                // Login Image
                Image.asset(
                  "images/login_image.png", // Ensure the path is correct and the asset is added in pubspec.yaml
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),

                // Welcome Text
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Email and Password Fields
                Column(
                  children: [
                    // Email Field
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF4F5F9),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Email",
                          labelText: "Email",
                          // border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    16.heightBox,

                    // Password Field
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF4F5F9),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Password",
                          labelText: "Password",
                          // border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    "Forgot Password".text.black.bold.xl.make(),
                  ],
                ),
                16.heightBox,
                // Login Button
                // Material(
                //   color: Colors.deepPurple,
                //   borderRadius: BorderRadius.circular(changeBtn ? 50 : 8),
                //   child: InkWell(
                //     onTap: () async {
                //       if (_formKey.currentState!.validate()) {
                //         setState(() {
                //           changeBtn = true;
                //           email = emailController.text;
                //           password = passwordController.text;
                //         });
                //         await Future.delayed(Duration(seconds: 1));

                //         setState(() {
                //           changeBtn = false;
                //         });
                //          login();
                //       }

                //     },
                //     child: AnimatedContainer(
                //       duration: Duration(seconds: 1),
                //       width: changeBtn ? 50 : 150,
                //       height: 50,
                //       alignment: Alignment.center,
                //       child: changeBtn
                //           ? Icon(Icons.done, color: Colors.white)
                //           : Text(
                //               "Login",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 18),
                //             ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          email = emailController.text;
                          password = passwordController.text;
                        });
                      }
                      login();
                    },
                    child: Text('Login'),
                  ),
                ),
                16.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Don't have an account?".text.make(),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: " Sign Up".text.black.bold.make()),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
