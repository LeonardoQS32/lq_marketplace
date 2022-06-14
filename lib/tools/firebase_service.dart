import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lq_marketplace/models/Product.dart';
import 'package:lq_marketplace/models/shopping_cart.dart';
import '../models/Person.dart';

class FirebaseService {
  static Person? person;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signIn(
    Person person, {
    Function? onSucess,
    Function? onFail,
  }) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
              email: person.email!, password: person.password!))
          .user;
      FirebaseService.person = person;
      FirebaseService.person!.id = user!.uid;
      onSucess!();
    } on PlatformException catch (e) {
      onFail!(debugPrint(e.toString()));
    }
  }

  Future<void> signUp(
    Person person, {
    Function? onSucess,
    Function? onFail,
  }) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: person.email!, password: person.password!))
          .user;
      person.id = user!.uid;
      onSucess!();
    } catch (e) {
      onFail!(debugPrint(e.toString()));
    }
  }

  addProducts(Product product) {
    _firestore.collection("products").add(product.toMap());
  }

  addVendas(ShoppingCart cart) {
    DocumentReference doc = _firestore.collection("sales").doc();
    doc.set(cart.toMap());
    for (int i = 0; i < cart.listProducts.length; i++) {
      _firestore
          .collection("sales/${doc.id}/products")
          .add(cart.listProducts[i].toMap());
    }
  }

  updateProducts(Product product,
      {Function? onSucess, Function? onFail}) async {
    try {
      await _firestore
          .collection("products")
          .doc(product.id)
          .update(product.toMap());
      onSucess!();
    } on Exception {
      // ignore: todo
      // TODO
      onFail!();
    }
  }

  deleteProduct(String idProduct) async {
    await _firestore.collection("products").doc(idProduct).delete();
  }

  Stream<QuerySnapshot> getProducts() {
    return _firestore.collection("products").snapshots();
  }

  getQntProduct(String idProduct) async {
    int x = 0;
    await _firestore
        .collection("products")
        .doc(idProduct)
        .get()
        .then((value) => x = value.get("qnt"));
    return x;
  }
}
