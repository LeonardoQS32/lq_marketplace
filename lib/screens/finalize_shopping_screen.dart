import 'package:flutter/material.dart';
import 'package:lq_marketplace/models/shopping_cart.dart';
import 'package:lq_marketplace/screens/home_screen.dart';
import 'package:lq_marketplace/tools/firebase_service.dart';

// ignore: must_be_immutable
class FinalizeShoppingScreen extends StatefulWidget {
  ShoppingCart cart;

  FinalizeShoppingScreen({Key? key, required this.cart}) : super(key: key);

  @override
  State<FinalizeShoppingScreen> createState() => _FinalizeShoppingScreenState();
}

class _FinalizeShoppingScreenState extends State<FinalizeShoppingScreen> {
  final List<String> formPaymentList = [
    "Dinheiro",
    "Cartão de crédito",
    "Cartão de débito",
    "Pix"
  ];
  int op = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalizar Compra"),
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
                        finalizeShopping();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                            side:
                                const BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                      child: const Text("Finalizar Compra",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                Expanded(
                  child: PopupMenuButton<int>(
                    position: PopupMenuPosition.under,
                    initialValue: op,
                    itemBuilder: (context) => [
                      for (int i = 0; i < formPaymentList.length; i++)
                        PopupMenuItem(
                          value: i,
                          child: Text(
                            formPaymentList[i],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                    onSelected: (value) {
                      setState(() {
                        op = value;
                      });
                    },
                    child: Container(
                      decoration: const ShapeDecoration(
                          color: Colors.black38,
                          shape: StadiumBorder(
                              side: BorderSide(color: Colors.white, width: 2))),
                      height: 50,
                      child: Center(
                        child: Text(
                          formPaymentList[op],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5,
                    child: SizedBox(
                      height: 50,
                      child: Center(
                          child: Text("Valor Total: R\$ ${widget.cart.amount}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
                child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                    itemBuilder: (context, index) => Center(
                          child: Text(
                            "${widget.cart.listProducts[index].qnt} X ${widget.cart.listProducts[index].name} por R\$ ${widget.cart.listProducts[index].price} cada.",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                    itemCount: widget.cart.listProducts.length),
              ),
            ))
          ],
        ),
      ),
    );
  }

  finalizeShopping() async {
    FirebaseService firebaseService = FirebaseService();
    widget.cart.formPayment = formPaymentList[op];
    widget.cart.personBought = firebaseService.getUser();
    await firebaseService.addVendas(widget.cart);

    for (int i = 0; i < widget.cart.listProducts.length; i++) {
      int qnt =
          await firebaseService.getQntProduct(widget.cart.listProducts[i].id);
      qnt = qnt - (widget.cart.listProducts[i].qnt) as int;

      if (qnt == 0) {
        await firebaseService.deleteProduct(widget.cart.listProducts[i].id);
      } else {
        widget.cart.listProducts[i].qnt = qnt;
        await firebaseService.updateProducts(widget.cart.listProducts[i]);
      }
      widget.cart.listProducts.removeAt(i);
    }
  }
}
