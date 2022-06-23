import 'package:flutter/material.dart';
import 'package:lq_marketplace/pages/administrative_page.dart';
import 'package:lq_marketplace/pages/sales_page.dart';
import 'package:lq_marketplace/pages/user_perfil_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _listPages = [];
  late int _indexPages;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    _indexPages = 0;

    _listPages.add(const SalesPage());
    _listPages.add(AdministrativePage());
    _listPages.add(const UserPerfilPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LQ Marketplace"), centerTitle: true),
      body: IndexedStack(
        index: _indexPages,
        children: _listPages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          currentIndex: _indexPages,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.store_mall_directory_outlined),
                label: "Vendas"),
            BottomNavigationBarItem(
                icon: Icon(Icons.admin_panel_settings_outlined),
                label: "Administrativo"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), label: "Perfil"),
          ]),
    );
  }

  void onTapped(int index) {
    setState(() {
      _indexPages = index;
    });
  }
}
