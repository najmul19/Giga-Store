import 'package:flutter/material.dart';
import 'package:giga_store_/Admin/add_product.dart';
import 'package:giga_store_/Admin/all_orders.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f3f6),
      appBar: AppBar(
        backgroundColor: Color(0xff1e2a47),
        centerTitle: true,
        title: "Admin Dashboard".text.xl4.bold.white.make(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.count(
          crossAxisCount: 2, // Creates a 2-column grid
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.5, // Adjust height/width ratio for the tiles
          children: [
            _buildGridTile(
              context,
              icon: Icons.add,
              title: "Add Product",
              backgroundColor: Colors.green,
              iconColor: Colors.white,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()));
              },
            ),
            _buildGridTile(
              context,
              icon: Icons.shopping_bag_outlined,
              title: "All Orders",
              backgroundColor: Colors.blueAccent,
              iconColor: Colors.white,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllOrders()));
              },
            ),
            _buildGridTile(
              context,
              icon: Icons.pending_actions,
              title: "Pending",
              backgroundColor: Colors.orange,
              iconColor: Colors.white,
              onTap: () {
                // Handle Pending Approvals Navigation
              },
            ),
            _buildGridTile(
              context,
              icon: Icons.settings,
              title: "Settings",
              backgroundColor: Colors.redAccent,
              iconColor: Colors.white,
              onTap: () {
                // Handle Settings Navigation
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridTile(
    BuildContext context, {
    required VoidCallback onTap,
    required IconData icon,
    required String title,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [backgroundColor.withOpacity(0.8), backgroundColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60,
                color: iconColor,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
