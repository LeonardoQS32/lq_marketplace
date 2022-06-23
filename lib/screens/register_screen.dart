import 'package:flutter/material.dart';
import 'package:lq_marketplace/models/Person.dart';
import 'package:lq_marketplace/tools/validator.dart';
import '../tools/firebase_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Person person = Person();
  late String _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8, top: 28),
        child: Column(
          children: [
            Card(
              color: Colors.black38,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Cadastro",
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: person.name,
                            onSaved: (value) => person.name = value,
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
                            initialValue: person.email,
                            onSaved: (value) => person.email = value,
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2)),
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
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            initialValue: person.password,
                            onSaved: (value) => person.password = value,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Senha",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2)),
                              icon: const Icon(Icons.key),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira uma senha.';
                              }
                              if (value.length < 6) {
                                return 'A senha precisa ter 6 caracteres no minimo.';
                              }
                              _confirmPassword = value;
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            initialValue: "",
                            onSaved: (value) => person.password = value,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Confirmar senha",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2)),
                              icon: const Icon(Icons.key),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira a senha novamente.';
                              }
                              if (value != _confirmPassword) {
                                return 'Por favor, repita a senha corretamente.';
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
                            firebaseService.signUp(person, onSucess: () {
                              Navigator.of(context).pop();
                            }, onFail: (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Erro ao tentar cadastrar: $e")));
                            });
                          }
                        },
                        child: const Text("Cadastrar"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
