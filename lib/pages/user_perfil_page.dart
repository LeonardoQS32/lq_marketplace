import 'package:flutter/material.dart';
import 'package:lq_marketplace/models/Person.dart';
import 'package:lq_marketplace/screens/login_screen.dart';
import 'package:lq_marketplace/screens/reset_password_screen.dart';
import 'package:lq_marketplace/screens/update_person_screen.dart';
import 'package:lq_marketplace/tools/firebase_service.dart';

class UserPerfilPage extends StatefulWidget {
  const UserPerfilPage({Key? key}) : super(key: key);

  @override
  State<UserPerfilPage> createState() => _UserPerfilPageState();
}

class _UserPerfilPageState extends State<UserPerfilPage> {
  late Person person;

  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    person = firebaseService.getUser();
    print("Email: ${person.email}");
    //person = Person.fromMap(
    //   {"name": "Leonardo", "email": "leonardoqueiroz@email.com"});
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            elevation: 5,
            child: Column(
              children: [
                const Center(
                    child: Icon(
                  Icons.account_box,
                  size: 120,
                )),
                Text(
                  "${person.name}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "${person.email}",
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 48,
            width: 256,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UpdatePersonScreen(
                        person: person,
                      ),
                    ),
                  );
                },
                child: const Text("Editar informações")),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 48,
            width: 256,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ResetPasswordScreen(),
                ));
              },
              child: const Text("Redefinir senha"),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 48,
            width: 256,
            child: ElevatedButton(
                onPressed: () {
                  firebaseService.userLogout(onSucess: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  }, onFail: (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Erro ao tentar sair: $e")));
                  });
                },
                child: const Text("Sair")),
          ),
        ],
      ),
    );
  }
}
