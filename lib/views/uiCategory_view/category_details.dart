import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/widgets_common/bg_uiWidget.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../controllers/product_controller.dart';
import '../../services/firestore_service.dart';
import 'item.detail.dart';

class CategoryDetail extends StatelessWidget {
  final String? title;

  const CategoryDetail({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
          stream: FireStoreServices.getProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No Data"),
              );
            } else {
              var data = snapshot.data!.docs;

              return Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            controller.subcat.length,
                            (index) => controller.subcat[index].text
                                .size(12)
                                .fontFamily(bold)
                                .color(darkFontGrey)
                                .makeCentered()
                                .box
                                .white
                                .rounded
                                .size(120, 60)
                                .margin(EdgeInsets.symmetric(horizontal: 4))
                                .make()),
                      ),
                    ),
                    20.heightBox,
                    Expanded(
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 250),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(data[index]["p_imgs"][0],
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover),
                                  10.heightBox,
                                  "${data[index]["p_name"]}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "\$${data[index]["p_price"]}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(Colors.red)
                                      .make(),
                                ],
                              )
                                  .box
                                  .white
                                  .margin(EdgeInsets.symmetric(horizontal: 4))
                                  .roundedLg
                                  .outerShadowSm
                                  .padding(EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                Get.to(
                                    () => ItemDetail(
                                        title: data[index]["p_name"]
                                    , data: data[index]),
                                    transition: Transition.cupertino,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInCubic);
                              });
                            })),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
