// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lq_marketplace/models/Product.dart';
import 'package:lq_marketplace/screens/add_product_screen.dart';
import 'package:lq_marketplace/screens/update_product_screen.dart';
import 'package:lq_marketplace/tools/firebase_service.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({Key? key}) : super(key: key);

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deposito"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseService.getProducts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> docSnap = snapshot.data!.docs;
                return ListView.separated(
                    itemBuilder: ((context, index) => Column(
                          children: [
                            Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 80,
                                    ),
                                    const SizedBox(width: 8),
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
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  "Quantidade:  ${docSnap[index].get("qnt")}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
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
                            Row(
                              children: [
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      Product product = Product(
                                          id: docSnap[index].id,
                                          name: docSnap[index].get("name"),
                                          price: docSnap[index].get("price"),
                                          qnt: docSnap[index].get("qnt"),
                                          descrition:
                                              docSnap[index].get("descrition"));

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateProductScreen(
                                                      product: product)));
                                    },
                                    color: Colors.blue,
                                    child: const Icon(Icons.restart_alt),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      AlertDialog alert = AlertDialog(
                                        title: const Text("Excluir produto"),
                                        content: const Text(
                                            "Tem certeza que deseja excluír produto?"),
                                        actions: [
                                          FlatButton(
                                              onPressed: () {
                                                _firebaseService.deleteProduct(
                                                    docSnap[index].id);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Sim")),
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Não"))
                                        ],
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    },
                                    color: Colors.red,
                                    child: const Icon(Icons.delete),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                    itemCount: docSnap.length);
              } else if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return const Text("Nenhum produto registrado");
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddProductScreen()));
        },
        backgroundColor: Colors.lightGreen,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
