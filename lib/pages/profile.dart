import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import 'onboarding.dart';

class Profile extends StatefulWidget {
  final String email, name;

  const Profile({super.key, required this.email, required this.name});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _logout() async {
    // Clear saved login data
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate back to the login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => Onboarding()),
      (route) => false, // Remove all routes
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.name.isNotEmpty ? widget.name : "Unknown User";
    final displayEmail =
        widget.email.isNotEmpty ? widget.email : "No Email Provided";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffecefe8),
        centerTitle: true,
        title: "Profile".text.xl3.bold.black.make(),
      ),
      backgroundColor: const Color(0xffecefe8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display Name
            displayName.text.xl3.bold.make(),
            10.heightBox, // Space between items

            // Display Email
            displayEmail.text.xl2.make(),
            20.heightBox, // Space between email and logout icon

            // Logout Icon
            IconButton(
              icon: const Icon(
                Icons.logout,
                size: 30,
                color: Colors.red,
              ),
              onPressed: () {
                // Show confirmation dialog for logout
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Confirm Logout"),
                    content: const Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context); // Close dialog
                          await _logout(); // Clear login data and navigate to login page
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
