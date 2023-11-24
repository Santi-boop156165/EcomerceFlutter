import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: "Cart is Empty".text.fontFamily(semibold).color(darkFontGrey).white.makeCentered(),
    );
  }
}
