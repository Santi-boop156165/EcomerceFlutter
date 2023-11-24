import 'package:ecomerce/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ourButton({onPressed, color, textColor,String? title}) {
  return ElevatedButton(
         style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            padding: const EdgeInsets.all(12)
         ),
          onPressed: onPressed,
          child:
          title!.text.color(textColor).fontFamily(semibold).size(16).make(),

  );

}
