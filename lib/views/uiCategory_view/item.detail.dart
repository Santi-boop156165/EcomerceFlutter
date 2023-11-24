import 'package:ecomerce/consts/list.dart';
import 'package:ecomerce/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../controllers/product_controller.dart';

class ItemDetail extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemDetail({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Scaffold(
        backgroundColor: Color(0xfffff6eb),
        appBar: AppBar(
          title: title!.text.fontFamily(bold).color(darkFontGrey).make(),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        autoPlayAnimationDuration: 1.seconds,
                        height: 250,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                        itemCount: data["p_imgs"].length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data["p_imgs"][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox,
                    title!.text
                        .fontFamily(semibold)
                        .size(18)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data["p_rating"]),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      maxRating: 5,
                      size: 25,
                    ),
                    10.heightBox,
                    "\$ ${data["p_price"]} "
                        .text
                        .fontFamily(bold)
                        .size(18)
                        .color(Colors.red)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller"
                                  .text
                                  .fontFamily(bold)
                                  .size(12)
                                  .color(darkFontGrey)
                                  .make(),
                              5.heightBox,
                              "${data["p_seller"]} "
                                  .text
                                  .fontFamily(bold)
                                  .size(18)
                                  .color(darkFontGrey)
                                  .make(),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child:
                              Icon(Icons.message_rounded, color: darkFontGrey),
                        )
                      ],
                    )
                        .box
                        .height(60)
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),
                    Obx( () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color"
                                    .text
                                    .fontFamily(bold)
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Row(
                                children: List.generate(
                                    data["p_colors"].length,
                                    (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .size(40, 40)
                                            .color(Color(data["p_colors"][index]))
                                            .roundedFull
                                            .margin(
                                                EdgeInsets.symmetric(horizontal: 4))
                                            .make().onTap(() {
                                              controller.changeColor(index);
                                        }),
                                        Visibility(
                                          visible: index == controller.colorIndex.value,
                                          child:  const Icon(Icons.done, color: Colors.white, size: 20,),)

                                      ],
                                    )),
                              )
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity"
                                    .text
                                    .fontFamily(bold)
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Obx(() =>  Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decrement();
                                          controller.calculateTotalPrice(
                                              int.parse(data["p_price"]));
                                        }, icon: Icon(Icons.remove)),
                                    controller.cuantity.value
                                        .text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increment(
                                            int.parse(data["p_quantity"])
                                          );
                                          controller.calculateTotalPrice(
                                              int.parse(data["p_price"]));
                                        }, icon: Icon(Icons.add)),
                                    10.widthBox,
                                    "In Stock ${data["p_quantity"]} "
                                        .text
                                        .size(12)
                                        .color(textfieldGrey)
                                        .fontFamily(bold)
                                        .make(),
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total"
                                    .text
                                    .fontFamily(bold)
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Row(
                                children: [
                                  "${controller.totalPrice.value}"
                                  .numCurrency
                                      .text
                                      .size(16)
                                      .color(Colors.red)
                                      .fontFamily(bold)
                                      .make(),
                                ],
                              ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make()
                        ],
                      ).box.white.shadowSm.make().p16(),
                    ),
                    "Description"
                        .text
                        .fontFamily(bold)
                        .size(14)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    "${data["p_desc"]} "
                        .text
                        .fontFamily(regular)
                        .size(12)
                        .color(textfieldGrey)
                        .make(),
                    10.heightBox,
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          itemDetaiilButtomList.length,
                          (index) => ListTile(
                                title: "${itemDetaiilButtomList[index]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  color: darkFontGrey,
                                ),
                              )),
                    ),
                    20.heightBox,
                    productosyoumaylike.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(imgP1,
                                        width: 150, fit: BoxFit.cover),
                                    10.heightBox,
                                    "Laptop Rzr 7&"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "\$ 1200"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(EdgeInsets.symmetric(horizontal: 4))
                                    .roundedLg
                                    .padding(EdgeInsets.all(8))
                                    .make()),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: ourButton(
                  title: "Add to Cart",
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {},
                ))
          ],
        ));
  }
}
