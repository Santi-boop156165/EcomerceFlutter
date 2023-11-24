import 'package:ecomerce/views/uiCart_screen/cart_screen.dart';
import 'package:ecomerce/views/uiHome_view/indexHome_screen.dart';
import 'package:ecomerce/views/uiProfile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../controllers/home_controller.dart';
import '../uiCategory_view/category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navbarItems = [
      BottomNavigationBarItem(
        icon: Image.asset(icHome,width: 26,),label: home,

      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCategories,width: 26,),label: categories,

      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCart,width: 26,),label: cart,

      ),
      BottomNavigationBarItem(
        icon: Image.asset(icProfile,width: 26,),label: profile,

      ),
    ];

    var navBody = [
      const IndexHome(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];



    return Scaffold(
      body: Column(
        children: [
          Obx(() =>
              Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
      ),
     bottomNavigationBar: Obx(() =>

        BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          type: BottomNavigationBarType.fixed,
            selectedItemColor: redColor,
            unselectedItemColor: fontGrey,
         backgroundColor: whiteColor,
           items: navbarItems,
            onTap: (index){
              controller.currentNavIndex.value = index;
            },
        ),
     ),
    );
  }
}

