import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  var  isLoading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();



  Future<UserCredential?> loginMethod({context})async{
    UserCredential? userCredential ;
    try {
      await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
     VxToast.show(context, msg: e.toString(), bgColor: Colors.red, textColor: Colors.white);
    }
    return userCredential;
  }


  Future<UserCredential?> registerMethod({email,password,context})async{
    UserCredential? userCredential ;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString(), bgColor: Colors.red, textColor: Colors.white);
    }
    return userCredential;
  }


  storeUserData({name,password,email}) async {
    DocumentReference store = await firestore.collection("users").doc(auth.currentUser!.uid);
    store.set({
      "name":name,
      "password":password,
      "email":email,
      "imageUrl": "imageUrl",
      "id": currentUser!.uid,
      "cart_count" : "00",
      "order_count" : "00",
      "wish_list_count" : "00",

    });
  }

  signOutMethod({context}) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString(), bgColor: Colors.red, textColor: Colors.white);
    }
  }

}