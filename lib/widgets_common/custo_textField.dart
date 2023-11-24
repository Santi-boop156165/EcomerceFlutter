import 'package:ecomerce/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextField({String? title, String? hint, controller,isPassword}) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    title!.text.color(redColor).fontFamily(semibold).size(16).make(),
    5.heightBox,
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        hintStyle:
            TextStyle(
                color: textfieldGrey,
                fontSize: 14,
                fontFamily: semibold),
        hintText: hint,
        isDense: true,
        fillColor: lightGrey,
        filled: true,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: redColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    10.heightBox
  ]);
}
