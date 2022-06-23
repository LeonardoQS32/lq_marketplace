import 'package:flutter/material.dart';
import '../tools/firebase_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String _confirmPassword = "", _newPassword = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redefinir senha'),
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
                    initialValue: _newPassword,
                    onSaved: (value) => _newPassword = value!,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Nova senha",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2)),
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
                    onSaved: (value) => _confirmPassword = value!,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirmar nova senha",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2)),
                      icon: const Icon(Icons.key),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a nova senha novamente.';
                      }
                      if (value != _confirmPassword) {
                        return 'Por favor, repita a nova senha corretamente.';
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
                    firebaseService.resetPassword(_newPassword, onSucess: () {
                      Navigator.of(context).pop();
                    }, onFail: (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Erro ao tentar redefinir senha: $e")));
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
