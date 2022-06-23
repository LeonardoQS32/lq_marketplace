import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lq_marketplace/models/Product.dart';
import 'package:lq_marketplace/models/shopping_cart.dart';
import 'package:lq_marketplace/screens/shopping_cart_screen.dart';
import 'package:lq_marketplace/tools/firebase_service.dart';

class SalesPage extends StatefulWidget {
  //ShoppingCart? cart;
  const SalesPage({Key? key}) : super(key: key);

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final FirebaseService _firebaseService = FirebaseService();
  List listProduct = [];

  late ShoppingCart cart;

  @override
  Widget build(BuildContext context) {
    cart = ShoppingCart(listProducts: listProduct);
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(5),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firebaseService.getProducts(),
              builder: ((BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> docSnap = snapshot.data!.docs;
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        TextEditingController qntController =
                            TextEditingController();

                        qntController.text = "1";
                        return Column(
                          children: [
                            Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 100,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              docSnap[index].get("name"),
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              " R\$ ${docSnap[index].get("price").toString()}",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  "Descrição:  ${docSnap[index].get("descrition")}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          int value =
                                              int.parse(qntController.text);
                                          if (value > 1) {
                                            value--;
                                          }
                                          qntController.text = value.toString();
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.redAccent,
                                            side: const BorderSide(
                                                color: Colors.white, width: 1)),
                                        child: const Icon(Icons.remove),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      //   initialValue: "1",
                                      controller: qntController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.white, width: 2)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                      child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        int value =
                                                int.parse(qntController.text),
                                            qntMax = docSnap[index].get("qnt");

                                        if (value < qntMax) {
                                          value++;
                                        }
                                        qntController.text = value.toString();
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.blueAccent,
                                          side: const BorderSide(
                                              color: Colors.white, width: 1)),
                                      child: const Icon(Icons.add),
                                    ),
                                  )),
                                ],
                              )),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    int i = checkId(docSnap[index].id);
                                    if (i == -1) {
                                      cart.listProducts.add(Product(
                                          id: docSnap[index].id,
                                          name: docSnap[index].get("name"),
                                          qnt: int.parse(qntController.text),
                                          price: docSnap[index].get("price"),
                                          descrition: docSnap[index]
                                              .get("descrition")));
                                      /*listProduct.add(Product(
                                          id: docSnap[index].id,
                                          name: docSnap[index].get("name"),
                                          qnt: int.parse(qntController.text),
                                          price: docSnap[index].get("price"),
                                          descrition: docSnap[index]
                                              .get("descrition")));*/
                                    } else {
                                      cart.listProducts[i].qnt =
                                          int.parse(qntController.text) +
                                              cart.listProducts[i].qnt!;
                                      if (cart.listProducts[i].qnt! >
                                          docSnap[index].get("qnt")) {
                                        cart.listProducts[i].qnt =
                                            docSnap[index].get("qnt");
                                      }
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.greenAccent,
                                      side: const BorderSide(
                                          color: Colors.white, width: 1)),
                                  child: const Icon(Icons.add_shopping_cart),
                                ),
                              )),
                            ])
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 5);
                      },
                      itemCount: docSnap.length);
                } else if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return const Text("Nenhum produto registrado.");
                }
              }),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //      Cart = ShoppingCart(listProducts);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShoppingCartScreen(cart: cart)));
          },
          backgroundColor: Colors.lightGreen,
          child: const Icon(
            Icons.shopping_cart_sharp,
            size: 40,
          ),
        ));
  }

  int checkId(String id) {
    for (int i = 0; i < listProduct.length; i++) {
      if (id == listProduct[i].id) {
        return i;
      }
    }

    return -1;
  }
}
