import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lq_marketplace/models/Product.dart';
import 'package:lq_marketplace/models/shopping_cart.dart';
import '../models/Person.dart';

class FirebaseService {
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
      person.id = user!.uid;
      onSucess!();
    } catch (e) {
      debugPrint("Erro = ${e.toString()}");
      onFail!(e.toString());
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
      user.updateDisplayName(person.name);
      onSucess!();
    } catch (e) {
      debugPrint("Erro = ${e.toString()}");
      onFail!(e.toString());
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

  updateProducts(Product product) async {
    await _firestore
        .collection("products")
        .doc(product.id)
        .update(product.toMap());
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

  Person getUser() {
    User user = _auth.currentUser!;
    return Person.fromMap(
        {"id": user.uid, "name": user.displayName, "email": user.email});
  }

  userLogout({Function? onSucess, Function? onFail}) async {
    try {
      await _auth.signOut();
      onSucess!();
    } catch (e) {
      onFail!(e.toString());
    }
  }

  resetInformation(
    Person person, {
    Function? onSucess,
    Function? onFail,
  }) async {
    try {
      await _auth.currentUser?.updateDisplayName(person.name);
      await _auth.currentUser?.updateEmail(person.email!);
      onSucess!();
    } catch (e) {
      onFail!(e.toString());
    }
  }

  resetPassword(
    String newPassword, {
    Function? onSucess,
    Function? onFail,
  }) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
      onSucess!();
    } catch (e) {
      onFail!(e.toString());
    }
  }
}
