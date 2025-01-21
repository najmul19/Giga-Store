import 'package:flutter/material.dart';
import 'package:giga_store_/pages/login.dart';
import 'package:giga_store_/pages/sign_up.dart';
import 'package:velocity_x/velocity_x.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 235, 231),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "images/headphone.PNG",
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              30.heightBox,

              // Stylish heading with enhanced text formatting
              "Explore\nThe Best\nProducts"
                  .text
                  .xl6
                  .bold
                  .make()
                  .px16()
                  .shimmer(primaryColor: Colors.redAccent),
              30.heightBox,

              // Row with Login and Signup buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Login Button with shadow and scale effect on tap
                  _buildOnboardingButton(
                    context,
                    label: "Sign In",
                    icon: Icons.login,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                  20.widthBox,
                  // Signup Button with shadow and scale effect on tap
                  _buildOnboardingButton(
                    context,
                    label: "Sign Up",
                    icon: Icons.person_add,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method to build buttons with icon and text
  Widget _buildOnboardingButton(BuildContext context,
      {required String label,
      required IconData icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.white),
              10.widthBox,
              label.text.xl2.bold.white.make(),
            ],
          ),
        ),
      ),
    );
  }
}
