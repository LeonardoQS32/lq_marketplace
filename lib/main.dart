import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lq_marketplace/screens/deposit_screen.dart';
import 'package:lq_marketplace/screens/home_screen.dart';
import 'package:lq_marketplace/screens/login_screen.dart';
import 'package:lq_marketplace/screens/register_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LQ MARKETPLACE',
      theme: ThemeData.dark(),
      initialRoute: '/loginScreen',
      routes: {
        '/homeScreen': (context) => const HomeScreen(),
        '/loginScreen': (context) => const LoginScreen(),
        '/registerScreen': (context) => const RegisterScreen(),
        '/depositScreen': (context) => const DepositScreen(),
      },
    );
  }
}
