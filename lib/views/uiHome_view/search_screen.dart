import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/consts/consts.dart';
import 'package:ecomerce/services/firestore_service.dart';
import 'package:get/get.dart';

import '../uiCategory_view/item.detail.dart';

class SearchScreen extends StatelessWidget {
  final String? title;

  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FireStoreServices.searchProducts(title!),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No se encontraron resultados"),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                children: data
                    .mapIndexed((currentValue, index) => Column(
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
                        ).box
                .gray100.margin(EdgeInsets.symmetric(horizontal: 4))
                .padding(EdgeInsets.all(8))
                .roundedSM
                .outerShadowSm
                    .make().onTap(() {
                          Get.to(() => ItemDetail(
                              title: "${data[index]["p_name"]}",
                              data: data[index]));
                        }))
                    .toList(
                      growable: false,
                    ),
              ),
            );
          }
        },
      ),
    );
  }
}
