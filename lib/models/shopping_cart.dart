// ignore: unused_import
import 'package:lq_marketplace/models/Person.dart';

class ShoppingCart {
  late String? id;
  List listProducts = [];
  late double? amount;
  late String? formPayment;
  late Person personBought;

  ShoppingCart(
      {required this.listProducts, this.amount, this.formPayment, this.id});

  void calculateAmount() {
    double x = 0;
    for (int i = 0; i < listProducts.length; i++) {
      x += listProducts[i].price * listProducts[i].qnt;
    }

    amount = x;
  }

  ShoppingCart.fromMap(Map<String, dynamic> map)
      : amount = map["amount"],
        formPayment = map["formPayment"];

  Map<String, dynamic> toMap() {
    return {
      "amount": amount,
      "formPayment": formPayment,
    };
  }
}
