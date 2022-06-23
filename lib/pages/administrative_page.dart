import 'package:flutter/material.dart';
import 'package:lq_marketplace/screens/deposit_screen.dart';

class AdministrativePage extends StatelessWidget {
  AdministrativePage({Key? key}) : super(key: key);

// Lista das opções que aparece na tela
  final List itensList = [
    {"labelText": "Deposito", "icon": Icons.border_all},
    {"labelText": "Vendas", "icon": Icons.shopping_cart_sharp}
  ];

  @override
  Widget build(BuildContext context) {
    // cria a lista na tela
    return ListView.builder(
      itemCount: itensList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
            elevation: 10,
            child: Container(
              height: 60,
              color: Colors.black38,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      itensList[index]["icon"],
                      size: 40,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      itensList[index]["labelText"],
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            onTapped(index, context);
          },
        );
      },
    );
  }

// função para quando clicar na tela
  onTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const DepositScreen()));
        break;
    }
  }
}
