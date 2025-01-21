import 'package:flutter/material.dart';
import 'package:giga_store/Utils/routs.dart';
import 'package:giga_store/core/store.dart';
import 'package:giga_store/pages/cart_page.dart';
import 'package:giga_store/pages/home_page.dart';
import 'package:giga_store/pages/login_page.dart';
import 'package:giga_store/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(VxState(
    store: MyStore(),
    child: GigaStore()));
}

class GigaStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.ligthTheme,
      darkTheme: MyTheme.darkTheme,
      initialRoute: MyRouts.homeRout,
      routes: {
        "/": (context) => LoginPage(), // Entry route
        MyRouts.homeRout: (context) => HomePage(), // Corrected unique name
        //"/login": (context) => LoginPage()
        MyRouts.cartRout: (context) => CartPage(),
      },
    );
  }
}
