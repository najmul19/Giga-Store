import 'package:flutter/material.dart';
import 'package:giga_store/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
class CataLogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "GigaStore".text.xl5.bold.color(MyTheme.darkBulishColor).make(),
        "Tranding Products".text.xl2.make(),
      ],
    );
  }
}