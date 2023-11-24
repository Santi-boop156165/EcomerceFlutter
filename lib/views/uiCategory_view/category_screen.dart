import 'package:ecomerce/consts/list.dart';
import 'package:ecomerce/widgets_common/bg_uiWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../controllers/product_controller.dart';
import 'category_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //print colors
     print("primaryColor: ${const Color(0xFFDCDCDC).value}");

    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
            itemCount: 9,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                children: [
                 Image.asset(categoriesImages[index], height: 120, width: 200, fit: BoxFit.cover),
                  10.heightBox,
                  categoriesList[index].text.fontFamily(bold).color(darkFontGrey).align(TextAlign.center).make(),

                ],

              ).box.gray50.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {

                controller.getSubCategories(categoriesList[index]);
                Get.to(() => CategoryDetail(title: categoriesList[index]));
              });
            }),
      ),
    ));
  }
}
