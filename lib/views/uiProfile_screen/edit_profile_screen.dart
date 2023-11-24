import 'dart:io';

import 'package:ecomerce/controllers/profile_controller.dart';
import 'package:ecomerce/widgets_common/bg_uiWidget.dart';
import 'package:ecomerce/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../widgets_common/custo_textField.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
  var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(() => SingleChildScrollView(
        child: Column(
            children: [

             controller.profileImgPath.isEmpty ? Image.asset(imgProfile2, height: 100, width: 100, fit: BoxFit.cover)
                  .box
                  .roundedFull
                  .clip(Clip.antiAlias)
                  .make() : Image.file(File(controller.profileImgPath.value), height: 100, width: 100, fit: BoxFit.cover),
              18.widthBox,
              ourButton(
                color: redColor,
                onPressed: () {
                  controller.changeImage(context: context);
                },
                textColor: Colors.white,
                title: "Change Photo",
              ),
              Divider(),
              20.heightBox,
              customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPassword: false),
              customTextField(
                  controller: controller.oldpasswordController,
                  hint: passwordHint,
                  title: password,
                  isPassword: true),
              customTextField(
                  controller: controller.passwordController,
                  hint: passwordHint,
                  title: password,
                  isPassword: true),
              20.heightBox,
              controller.isLoading.value ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ): SizedBox(
                width: context.screenWidth - 30,
                child: ourButton(
                  color: redColor,
                  onPressed: () async{
                    controller.isLoading(true);

                  if(controller.profileImgPath.value.isNotEmpty){
                    await  controller.uploadImage();
                  }else{

                    if(data["password"] != controller.oldpasswordController.text){
                      VxToast.show(context, msg: "Old Password is not correct", bgColor: Colors.red, textColor: Colors.white);
                      return;
                    }else{

                      controller.changeAuthPassword(
                          context: context,
                          password: controller.oldpasswordController.text,
                          newpassword: controller.passwordController.text,
                          email: data["email"]);
                      await controller.updateProfile(
                          name: controller.nameController.text,
                          password: controller.passwordController.text,
                          imgUrl: controller.profileImageLink,
                          context: context);
                      VxToast.show(context, msg: "Profile Updated Successfully", bgColor: Colors.green, textColor: Colors.white);

                    }
                    controller.isLoading(false);

                  }


                  },
                  textColor: Colors.white,
                  title: "Save",
                ),
              ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(EdgeInsets.all(16))
              .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
      ),
      ),
    ));
  }
}
