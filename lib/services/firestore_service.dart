

import 'package:ecomerce/consts/consts.dart';

class FireStoreServices {

  static getUser(String uid)  {
    return firestore.collection(usersCollections).where("id", isEqualTo: uid).snapshots();

  }

  static getProducts(category)  {
    return firestore.collection(productsCollections).where("p_category", isEqualTo: category).snapshots();
  }


  static getFeaturedProducts()  {
    return firestore.collection(productsCollections).where("is_featured", isEqualTo: true).get();

  }

  static searchProducts(String query)  {
    return firestore.collection(productsCollections).where("p_name", isGreaterThanOrEqualTo: query).get();
  }

  static getAllProducts()  {
    return firestore.collection(productsCollections).snapshots();
  }


}