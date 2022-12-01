import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/home_screen.dart';

class CreateGroup extends StatelessWidget {
  const CreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: crear grupo screen

    return Scaffold(
      //--------------------appbar--------------------
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text("Crear Grupo"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              //todo: conectar a buscar grupo
              onPressed: () {},
              icon: const Icon(Icons.search),
              tooltip: 'buscar grupos',
            ),
          ]),
      //--------------------body--------------------
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descripcion',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Clave',
            ),
          ),
        ],
      ),
      //--------------------BottomNavigationBar------------------------------
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Confirmar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Cancelar',
          )
        ],
        currentIndex: 0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.red,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (index == 1) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
        },
      ),
    );
  }
}
