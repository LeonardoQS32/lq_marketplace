import 'package:flutter/material.dart';
import 'package:lq_marketplace/models/Product.dart';
import 'package:lq_marketplace/tools/firebase_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Product product = Product();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Produto"),
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
                              initialValue: product.name,
                              onSaved: (value) => product.name = value,
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
                              onSaved: (value) =>
                                  product.price = double.parse(value!),
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
                              onSaved: (value) =>
                                  product.qnt = int.parse(value!),
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
                              initialValue: product.descrition,
                              onSaved: (value) => product.descrition = value,
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
                              firebase.addProducts(product);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text("Adicionar"),
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
