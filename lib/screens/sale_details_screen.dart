import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lq_marketplace/models/shopping_cart.dart';
import 'package:lq_marketplace/tools/firebase_service.dart';

// ignore: must_be_immutable
class SaleDetailScreen extends StatefulWidget {
  ShoppingCart cart;
  SaleDetailScreen({Key? key, required this.cart}) : super(key: key);

  @override
  State<SaleDetailScreen> createState() => _SaleDetailScreenState();
}

class _SaleDetailScreenState extends State<SaleDetailScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da compra'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                StreamBuilder(
                  stream: _firebaseService.getPersonAbouth(widget.cart.id!),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> elements = snapshot.data!.docs;
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('Cliente:   ${elements[0].get("name")}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Email do cliente:  ${elements[0].get("email")}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      );
                    } else if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      return const Text('nothin');
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Forma de pagamento:  ${widget.cart.formPayment}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text("Valor total:   R\$${widget.cart.amount}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(
                  height: 4,
                ),
                StreamBuilder(
                  stream: _firebaseService.getProductsSold(widget.cart.id),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> elements = snapshot.data!.docs;
                      return Expanded(
                        child: Card(
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.separated(
                                itemBuilder: ((context, index) => Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                          "${elements[index].get("name")}    "
                                          "R\$${elements[index].get("price")}   "
                                          " X ${elements[index].get("qnt")}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    )),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 8,
                                    ),
                                itemCount: elements.length),
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      return const Text('nothin');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
