import 'package:ecomerce/consts/consts.dart';
import 'package:ecomerce/views/uiCategory_view/category_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 40,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .white
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .padding(EdgeInsets.all(8))
      .roundedSM
      .outerShadowSm
      .make().onTap(() {
        Get.to(() => CategoryDetail(title: title) );
  });
}
