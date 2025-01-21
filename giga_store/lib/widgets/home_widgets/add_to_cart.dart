import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giga_store/core/store.dart';
import 'package:giga_store/models/cart.dart';
import 'package:giga_store/models/catalog.dart';
import 'package:giga_store/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class AddtoCart extends StatelessWidget {
  final Item catalog;
  AddtoCart({super.key, required this.catalog});

  // final _cart = CartModel();
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);

    final CartModel _cart =
        (VxState.store as MyStore).cart; // no need extra model creation
    bool isInCart = _cart.items.contains(catalog) ?? false;
    return ElevatedButton(
        onPressed: () {
          if (!isInCart) {
            // isInCart = !isInCart;
            // final _catalog = CatalogModel();
            // _cart.catalog = _catalog;
            //_cart.add(catalog);
            AddMutation(catalog);
            //setState(() {});
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyTheme.darkBulishColor),
            shape: MaterialStateProperty.all(StadiumBorder())),
        child: isInCart
            ? Icon(
                Icons.done,
                color: Colors.white,
              )
            : Icon(
                CupertinoIcons.cart_badge_plus,
                color: Colors.white,
              ));
  }
}
