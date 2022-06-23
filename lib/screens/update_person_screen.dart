import 'package:flutter/material.dart';
import 'package:lq_marketplace/screens/home_screen.dart';
import '../models/Person.dart';
import '../tools/firebase_service.dart';
import '../tools/validator.dart';

// ignore: must_be_immutable
class UpdatePersonScreen extends StatefulWidget {
  Person? person;
  UpdatePersonScreen({Key? key, this.person}) : super(key: key);

  @override
  State<UpdatePersonScreen> createState() => _UpdatePersonScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _UpdatePersonScreenState extends State<UpdatePersonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar informações'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8, top: 28),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.person!.name,
                    onSaved: (value) => widget.person!.name = value,
                    decoration: InputDecoration(
                      labelText: "Nome",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2)),
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
                    initialValue: widget.person!.email,
                    onSaved: (value) => widget.person!.email = value,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2)),
                      icon: const Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um email.';
                      }
                      if (!emailValidator(value)) {
                        return 'Email invalido, por favor insira um email valido.';
                      }
                      return null;
                    },
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
                    FirebaseService firebaseService = FirebaseService();
                    firebaseService.resetInformation(widget.person!,
                        onSucess: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                    }, onFail: (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Erro ao tentar redefinir informações: $e")));
                    });
                  }
                },
                child: const Text("Redefinir"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
