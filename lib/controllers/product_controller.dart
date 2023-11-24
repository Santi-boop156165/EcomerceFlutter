import 'package:ecomerce/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subcat = <String>[].obs;
  var cuantity = 1.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  getSubCategories(String title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decodedData = categoriesModelFromJson(data);
    var s = decodedData.categories
        .where((element) => element.name == title)
        .toList();
    for (var i in s[0].subcategories) {
      subcat.add(i);
    }
  }

  changeColor(int index) {
    colorIndex.value = index;
  }

  increment(totalQuanity) {
    if(cuantity.value < totalQuanity){
      cuantity.value++;
    }

  }
  decrement() {
    if(cuantity.value > 1){
      cuantity.value--;
    }

  }

  calculateTotalPrice(price){
    totalPrice.value = price * cuantity.value;
  }
}
