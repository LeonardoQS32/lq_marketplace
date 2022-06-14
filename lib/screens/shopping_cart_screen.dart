// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lq_marketplace/models/shopping_cart.dart';
import 'package:lq_marketplace/screens/finalize_shopping_screen.dart';
import 'package:lq_marketplace/tools/firebase_service.dart';

// ignore: must_be_immutable
class ShoppingCartScreen extends StatefulWidget {
  ShoppingCart cart;

  ShoppingCartScreen({Key? key, required this.cart}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  FirebaseService firebase = FirebaseService();

  @override
  Widget build(BuildContext context) {
    widget.cart.calculateAmount();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho de compras"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if (widget.cart.listProducts.isNotEmpty) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  FinalizeShoppingScreen(cart: widget.cart),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Nenhum item no carrinho.")));
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45),
                              side: const BorderSide(
                                  color: Colors.black, width: 2),
                            ),
                          ),
                        ),
                        child: const Text("Finalizar compra",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20))),
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                Expanded(
                  child: Container(
                    decoration: const ShapeDecoration(
                        color: Colors.black38,
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.white, width: 2))),
                    height: 50,
                    child: Center(
                      child: Text(
                        "Valor total: R\$ ${widget.cart.amount}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    TextEditingController qntController =
                        TextEditingController();
                    qntController.text =
                        widget.cart.listProducts[index].qnt.toString();
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
                                          widget.cart.listProducts[index].name,
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
                                          " R\$ ${widget.cart.listProducts[index].price}",
                                          style: const TextStyle(fontSize: 16),
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
                              "Descrição:  ${widget.cart.listProducts[index].descrition}",
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
                                      setState(() {
                                        if (widget
                                                .cart.listProducts[index].qnt >
                                            1) {
                                          widget.cart.listProducts[index].qnt--;
                                        }
                                      });
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
                                  controller: qntController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
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
                                  onPressed: () async {
                                    int qntMax = await firebase.getQntProduct(
                                        widget.cart.listProducts[index].id);
                                    setState(() {
                                      if (widget.cart.listProducts[index].qnt <
                                          qntMax) {
                                        widget.cart.listProducts[index].qnt++;
                                      }
                                    });
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
                                AlertDialog alert = AlertDialog(
                                  title: const Text("Excluir produto"),
                                  content: const Text(
                                      "Tem certeza que deseja remover este produto?"),
                                  actions: [
                                    FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            widget.cart.listProducts
                                                .removeAt(index);
                                          });
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
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  side: const BorderSide(
                                      color: Colors.white, width: 1)),
                              child: const Icon(Icons.delete),
                            ),
                          )),
                        ])
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 5);
                  },
                  itemCount: widget.cart.listProducts.length),
            ),
          ],
        ),
      ),
    );
  }
}
