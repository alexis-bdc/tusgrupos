import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/menu_drawer.dart';

class BuscarGrupo extends StatelessWidget {
  BuscarGrupo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //--------------------appbar--------------------
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Buscar Grupo'),
      ),
      body: const Center(
        child: Text(
          'Buscar Grupo',
          style: TextStyle(fontSize: 24),
        ),
      ),
      //--------------------drawer--------------------
      drawer: const MenuDrawer(),

      //--------------------body--------------------
    );
  }
}
