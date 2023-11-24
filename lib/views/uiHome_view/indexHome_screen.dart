import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/consts/list.dart';
import 'package:ecomerce/controllers/home_controller.dart';
import 'package:ecomerce/services/firestore_service.dart';
import 'package:ecomerce/views/uiCategory_view/item.detail.dart';
import 'package:ecomerce/views/uiHome_view/components/featured_button.dart';
import 'package:ecomerce/views/uiHome_view/search_screen.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../controllers/product_controller.dart';
import '../../widgets_common/home_button.dart';

class IndexHome extends StatelessWidget {
  const IndexHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    Get.put(ProductController());
    return Container(
      padding: const EdgeInsets.all(12),
      color: Color(0xfffffaed),
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: searchanything,
                  hintStyle: TextStyle(color: fontGrey),
                  suffixIcon: Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmpty) {
                      Get.to(() => SearchScreen(
                          title: controller.searchController.text));
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: whiteColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: whiteColor),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      itemCount: brandsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(brandsList[index]),
                                  fit: BoxFit.cover)),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2,
                          (index) => homeButton(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 2.5,
                                icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                title: index == 0 ? todayDeals : flashSale,
                              )),
                    ),
                    SizedBox(height: 10),
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 150,
                      itemCount: secondBrandsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(secondBrandsList[index]),
                                  fit: BoxFit.fill)),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homeButton(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 3.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? topCategories
                                    : index == 1
                                        ? brands
                                        : topSeller,
                              )),
                    ),
                    SizedBox(height: 15),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text
                            .color(darkFontGrey)
                            .size(18)
                            .fontFamily(semibold)
                            .make()),
                    SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Column(
                            children: [
                              featuredButton(
                                  icon: featuresList1[index],
                                  title: featuredTitles1[index]),
                              SizedBox(height: 10),
                              featuredButton(
                                  icon: featuresList2[index],
                                  title: featuredTitles2[index])
                            ],
                          ),
                        ).toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(color: Color(0xffffd391)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text
                              .color(darkFontGrey)
                              .size(18)
                              .fontFamily(semibold)
                              .make(),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FireStoreServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(redColor),
                                  ));
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return const Center(child: Text("No Data"));
                                } else {
                                  var data = snapshot.data!.docs;

                                  return Row(
                                    children: List.generate(
                                      data.length,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                              data[index]["p_imgs"][0],
                                              width: 150,
                                              fit: BoxFit.cover),
                                          SizedBox(height: 10),
                                          "${data[index]["p_name"]}"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          SizedBox(height: 10),
                                          "\$${data[index]["p_price"]}"
                                              .text
                                              .fontFamily(semibold)
                                              .color(Colors.red)
                                              .make(),
                                        ],
                                      )
                                          .box
                                          .white
                                          .margin(EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .roundedLg
                                          .padding(EdgeInsets.all(8))
                                          .make()
                                          .onTap(() {
                                        Get.to(() => ItemDetail(
                                            title: "${data[index]["p_name"]}",
                                            data: data[index]));
                                      }),
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    StreamBuilder(
                        stream: FireStoreServices.getAllProducts(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(redColor),
                            ));
                          }else{

                            var data = snapshot.data!.docs;
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    mainAxisExtent: 300,
                                    crossAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(data[index]["p_imgs"][0],
                                          width: 200, height: 200, fit: BoxFit.cover),
                                      SizedBox(height: 10),
                                      "${data[index]["p_name"]}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      SizedBox(height: 10),
                                      "\$ ${data[index]["p_price"]} "
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
                                      .padding(EdgeInsets.all(12))
                                      .make().onTap(() {
                                        Get.to(() => ItemDetail(title: "${data[index]["p_name"]}", data: data[index]));
                                  });
                                });
                          }
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
