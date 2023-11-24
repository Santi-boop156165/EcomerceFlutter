import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../consts/consts.dart';

class ProfileController extends GetxController{

  var profileImgPath = "".obs;

  var nameController = TextEditingController();
  var oldpasswordController = TextEditingController();
  var passwordController = TextEditingController();
  var profileImageLink = "";

  var isLoading = false.obs;

  changeImage({context}) async{
   try{
     final img = await ImagePicker().pickImage(source: ImageSource.gallery);
     if(img == null) return;
      profileImgPath.value = img.path;
    }catch(e){
      VxToast.show(context!, msg: e.toString(), bgColor: Colors.red, textColor: Colors.white);
   }
  }

  uploadImage() async{
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name,password,imgUrl,context}) async{
    try{
      var store =  firestore.collection(usersCollections).doc(currentUser!.uid);
      await store.set({
        "name":name,
        "password":password,
        "imageUrl": imgUrl,
      }, SetOptions(merge: true));
      isLoading(false);
      VxToast.show(context, msg: "Profile Updated Successfully", bgColor: Colors.green, textColor: Colors.white);
    }catch(e){
      VxToast.show(context, msg: e.toString(), bgColor: Colors.red, textColor: Colors.white);
    }
  }


  changeAuthPassword({context, password, newpassword, email}) async{
    try{
        final cred = EmailAuthProvider.credential(email: email, password: password);
        await currentUser!.reauthenticateWithCredential(cred).then((value){
          currentUser!.updatePassword(newpassword);
        });
    }catch(e){
      VxToast.show(context, msg: e.toString(), bgColor: Colors.red, textColor: Colors.white);
    }
  }



}