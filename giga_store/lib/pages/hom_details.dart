import 'package:flutter/material.dart';
import 'package:giga_store/models/catalog.dart';
import 'package:giga_store/widgets/home_widgets/add_to_cart.dart';
import 'package:giga_store/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomDetails extends StatelessWidget {
  final Item catalog;
  const HomDetails({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "\$${catalog.price}".text.bold.xl4.red800.make(),
            AddtoCart(catalog: catalog) .wh(100, 40)
          ],
        ).p16(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: MyTheme.creamColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
                    tag: Key(catalog.id.toString()),
                    child: Image.network(catalog.image))
                .h32(context),
            Expanded(
                child: VxArc(
              height: 30,
              arcType: VxArcType.convey,
              edge: VxEdge.top,
              child: Container(
                color: Colors.white,
                width: context.screenWidth,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    catalog.name.text.bold.xl4
                        .color(MyTheme.darkBulishColor)
                        .bold
                        .make(),
                    catalog.desc.text.textStyle(context.captionStyle).xl.make(),
                    10.heightBox,
                    "Abu Sayed (Bengali: আবু সাঈদ; 1998/1999  16 July 2024) was a Bangladeshi student activist who was shot dead by the Bangladesh Police on 16 July 2024, while participating in the 2024 Bangladesh quota reform movement. "
                        .text
                        .textStyle(context.captionStyle)
                        .make()
                        .p16(),
                  ],
                ).py64(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
