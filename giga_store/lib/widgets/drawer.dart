import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        "https://scontent.fdac22-1.fna.fbcdn.net/v/t39.30808-6/455890343_999955728807433_6785008603388102544_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeHh-3OOKCdbQJPAhBxAYUfMzO5wu3-B-DDM7nC7f4H4MKGrh_W2vgSraHQD4DIfeAaRRtQqpmLe059Ze9jXG6gp&_nc_ohc=fwZtrjCmbS8Q7kNvgHidfBu&_nc_zt=23&_nc_ht=scontent.fdac22-1.fna&_nc_gid=AOoqDVUhdZr_lM7lbYVw2AZ&oh=00_AYAi5JX2_3iUE_phuryYXKnNrsoczHJ7iqsp4lFVS8NafQ&oe=673E5278";
    return Drawer(
      child: Container(
        color: Colors.deepPurple,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                //decoration: BoxDecoration(color: Colors.amber,),
                accountName: Text("Md Najmul Islam"),
                accountEmail: Text("mdnajmulislam10992@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                "Profile",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.mail,
                color: Colors.white,
              ),
              title: Text(
                "Email me",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
