import 'package:ecomerce/views/uiHome_view/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets_common/appLogo_widget.dart';
import '../../widgets_common/bg_uiWidget.dart';
import '../../widgets_common/custo_textField.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool? isCheck = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
              child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogo(),
              20.heightBox,
              appname.text.fontFamily(bold).size(22).make(),
              5.heightBox,
              Obx(() => Column(
                  children: [
                    customTextField(hint: nameHint, title: name, controller: nameController, isPassword: false),
                    customTextField(hint: emailHint, title: email, controller: emailController, isPassword: false),
                    customTextField(hint: passwordHint, title: password, controller: passwordController, isPassword: true),
                    customTextField(hint: passwordHint, title: retypePassword, controller: retypePasswordController, isPassword: true),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: forgotPassword.text
                                .fontFamily(semibold)
                                .size(14)
                                .make())),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: redColor,
                            checkColor: whiteColor,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            }),
                        10.widthBox,
                        Expanded(
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "I agree to the",
                                style: TextStyle(
                                    color: fontGrey, fontFamily: semibold)),
                            TextSpan(
                                text: termsAndConditions,
                                style: TextStyle(
                                    color: redColor, fontFamily: semibold)),
                            TextSpan(
                                text: "&",
                                style: TextStyle(
                                    color: fontGrey, fontFamily: semibold)),
                            TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                    color: fontGrey, fontFamily: semibold)),
                          ])),
                        ),
                      ],
                    ),
                    8.heightBox,
                   controller.isLoading.value? const CircularProgressIndicator(
                     valueColor: AlwaysStoppedAnimation<Color>(redColor),
                   ) : ourButton(
                        onPressed: () async{
                          if(isCheck != false){
                            controller.isLoading(true);
                            try {
                              await controller.registerMethod(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context).then((value) {
                                  return controller.storeUserData(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                              }).then((value) {
                                VxToast.show(context, msg: "Register Successfully", bgColor: Colors.green, textColor: Colors.white);
                                Get.offAll(() => const HomeScreen());
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString(), bgColor: Colors.red, textColor: Colors.white);
                            }finally{
                              controller.isLoading(false);
                            }
                          }
                        },
                        title: signUp,
                        color: isCheck! ? redColor : lightGrey,
                        textColor: whiteColor)
                        .box
                        .width(context.screenWidth - 50)
                        .make(),
                    8.heightBox,
                    RichText(text: const TextSpan(children: [
                      TextSpan(
                          text: AlreadyHaveAnAccount,
                          style: TextStyle(
                              color: fontGrey, fontFamily: semibold)),
                      TextSpan(
                          text: login,
                          style: TextStyle(color: redColor, fontFamily: semibold)),
                    ])).onTap(() {
                      Get.back();
                    })
                  ],
                ),
              ),
            ],
          )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowXl
                  .make())),
    );
  }
}
