import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lq_marketplace/models/shopping_cart.dart';
import 'package:lq_marketplace/screens/sale_details_screen.dart';
import 'package:lq_marketplace/tools/firebase_service.dart';

class ListSalesScreen extends StatelessWidget {
  ListSalesScreen({Key? key}) : super(key: key);

  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseService.getSales(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> docSnap = snapshot.data!.docs;
                return ListView.separated(
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                StreamBuilder(
                                    stream: _firebaseService
                                        .getPersonAbouth(docSnap[index].id),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        List<DocumentSnapshot> elements =
                                            snapshot.data!.docs;
                                        return Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  'Cliente:   ${elements[0].get("name")}',
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
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (!snapshot.hasData) {
                                        return const CircularProgressIndicator();
                                      } else {
                                        return const Text('nothin');
                                      }
                                    }),
                                const SizedBox(
                                  height: 12,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      "Valor total:   R\$${docSnap[index].get("amount")}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Forma de pagamento:  ${docSnap[index].get("formPayment")}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          ShoppingCart cart = ShoppingCart(
                            listProducts: [],
                            id: docSnap[index].id,
                            amount: docSnap[index].get("amount"),
                            formPayment: docSnap[index].get("formPayment"),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SaleDetailScreen(
                                cart: cart,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemCount: docSnap.length);
              } else if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return const Text("Nenhuma venda registrada");
              }
            }),
      ),
    );
  }
}
