import 'package:ecomerce/consts/consts.dart';
import 'package:ecomerce/widgets_common/appLogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../uiAuth_view/login.dart';
import '../uiHome_view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  changeUi(){
    Future.delayed(const Duration(seconds: 3),(){
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.offAll(() => const LoginUi());
        } else {
          Get.offAll(() => const HomeScreen());
        }
      });
    });
  }
  @override
  void initState() {
    changeUi();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Align(
            alignment: Alignment.topLeft ,
            child: Image.asset(icSplashBg
            , width: 300,
            ),
          ),
            20.heightBox,
            appLogo(),
            10.heightBox,
            appname.text.fontFamily(bold).white.size(22).make(),
            5.heightBox,
            appversion.text.white.make(),
            credits.text.wide.fontFamily(semibold).make(),
            30.heightBox



          ],
        ),
      ),
    );
  }
}
