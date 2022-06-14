import 'package:flutter/material.dart';
import 'package:lq_marketplace/models/Product.dart';
import 'package:lq_marketplace/tools/firebase_service.dart';

// ignore: must_be_immutable
class UpdateProductScreen extends StatefulWidget {
  Product product;

  UpdateProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //Product product = widget.product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atualizar Produto"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: Colors.black38,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: widget.product.name,
                              onSaved: (value) => widget.product.name = value,
                              decoration: InputDecoration(
                                labelText: "Nome",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2)),
                                icon: const Icon(Icons.abc),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira um nome.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              initialValue: widget.product.price.toString(),
                              onSaved: (value) =>
                                  widget.product.price = double.parse(value!),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Preço",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2)),
                                icon: const Icon(Icons.attach_money),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira um preço.';
                                }
                                if (double.parse(value) <= 0) {
                                  return 'O preço precisa ser maior que zero';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              initialValue: widget.product.qnt.toString(),
                              onSaved: (value) =>
                                  widget.product.qnt = int.parse(value!),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Quantidade",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2)),
                                icon: const Icon(Icons.numbers),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira uma quantidade.';
                                }
                                if (0 >= (int.parse(value))) {
                                  return 'A quantidade precisa ser maior que zero.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              initialValue: widget.product.descrition,
                              onSaved: (value) =>
                                  widget.product.descrition = value,
                              decoration: InputDecoration(
                                labelText: "Descrição",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2)),
                                icon: const Icon(Icons.abc),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 48,
                        width: 128,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              FirebaseService firebase = FirebaseService();
                              firebase.updateProducts(widget.product,
                                  onSucess: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Produto atualizado com sucesso.")));
                                Navigator.of(context).pop();
                              }, onFail: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Falha ao atualizar produto.")));
                              });
                            }
                          },
                          child: const Text("Atualizar"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
