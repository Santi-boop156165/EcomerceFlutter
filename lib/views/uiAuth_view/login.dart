import 'package:ecomerce/consts/list.dart';
import 'package:ecomerce/controllers/auth_controller.dart';
import 'package:ecomerce/views/uiAuth_view/signup_view.dart';
import 'package:ecomerce/views/uiHome_view/home_screen.dart';
import 'package:ecomerce/widgets_common/bg_uiWidget.dart';
import 'package:ecomerce/widgets_common/custo_textField.dart';
import 'package:ecomerce/widgets_common/our_button.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../widgets_common/appLogo_widget.dart';

class LoginUi extends StatelessWidget {
  const LoginUi({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

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
          Obx(
            () => Column(
              children: [
                customTextField(
                    hint: emailHint,
                    title: email,
                    isPassword: false,
                    controller: controller.emailController),
                customTextField(
                    hint: passwordHint,
                    title: password,
                    isPassword: true,
                    controller: controller.passwordController),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: forgotPassword.text
                            .fontFamily(semibold)
                            .size(14)
                            .make())),
                8.heightBox,
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(redColor),
                      )
                    : ourButton(
                            onPressed: () async {

                              controller.isLoading(true);
                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context,
                                      msg: "Login Success",
                                      bgColor: Colors.green,
                                      textColor: Colors.white);
                                  Get.offAll(() => const HomeScreen());
                                }else{
                                  controller.isLoading(false);
                                }
                              });
                            },
                            title: login,
                            color: redColor,
                            textColor: whiteColor)
                        .box
                        .width(context.screenWidth - 50)
                        .make(),
                8.heightBox,
                createAccount.text
                    .color(fontGrey)
                    .fontFamily(semibold)
                    .size(14)
                    .make(),
                8.heightBox,
                ourButton(
                        onPressed: () {
                          Get.to(() => SignupScreen());
                        },
                        title: signUp,
                        color: lightGrey,
                        textColor: redColor)
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                10.heightBox,
                loginWith.text
                    .color(fontGrey)
                    .fontFamily(semibold)
                    .size(14)
                    .make(),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: lightGrey,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          )),
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowXl
                .make(),
          )
        ],
      )),
    ));
  }
}
