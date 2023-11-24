import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/consts/consts.dart';
import 'package:get/get.dart';

import '../../consts/list.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../services/firestore_service.dart';
import '../../widgets_common/bg_uiWidget.dart';
import '../uiAuth_view/login.dart';
import 'components/details_card.dart';
import 'edit_profile_screen.dart';
// Asegúrate de que otras importaciones necesarias estén aquí.

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FireStoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.edit, color: Colors.white))
                      .onTap(() {

                        controller.nameController.text = data['name'];



                    Get.to(() =>  EditProfileScreen(data: data));
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [

                      Image.asset(imgProfile2,
                              height: 100, width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
                      18.widthBox,
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            5.heightBox,
                            "${data['email']}"
                                .text
                                .fontFamily(regular)
                                .white
                                .make(),
                            5.heightBox,
                          ])),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 1, color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signOutMethod(context: context);
                            Get.offAll(() => const LoginUi());
                          },
                          child: logout.text.fontFamily(semibold).white.make())
                    ],
                  ),
                ),
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailCard(
                        count: data['cart_count'],
                        title: "Orders",
                        width: context.screenWidth / 3.4),
                    detailCard(
                        count: data['wish_list_count'],
                        title: "Orders",
                        width: context.screenWidth / 3.4),
                    detailCard(
                        count: data['order_count'],
                        title: "Orders",
                        width: context.screenWidth / 3.4),
                  ],
                ),
                ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                              color: lightGrey,
                            ),
                        itemCount: profileButtomList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.asset(
                              profileButtonIcon[index],
                              width: 22,
                            ),
                            title: profileButtomList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        })
                    .box
                    .white
                    .rounded
                    .margin(EdgeInsets.all(12))
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .shadowSm
                    .make()
                    .box
                    .color(redColor)
                    .make()
              ]));
            }
          },
        ),
      ),
    );
  }
}
