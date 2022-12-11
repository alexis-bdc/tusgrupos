import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/buscar_grupo_screen.dart';
import 'package:tusgrupos/screens/crear_grup_screen.dart';
import 'package:tusgrupos/screens/menu_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //todo: define text style and colors

    // TODO: implement build home screen scaffold
    return Scaffold(
        //--------------------appbar--------------------
        appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const Text("Menu"),
            actions: <Widget>[
              IconButton(
                //todo: conectar a buscar grupo
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuscarGrupo()),
                  );
                },
                icon: const Icon(Icons.search),
                tooltip: 'buscar grupos',
              ),
            ]),
        //--------------------drawer--------------------
        drawer: const MenuDrawer(),

        //--------------------body--------------------
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //todo: conectar a lista de grupos participante
            ],
          ),
        ),

        //--------------------floating action button--------------------
        floatingActionButton: FloatingActionButton(
            //todo: conectar a crear grupos
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CreateGroup()));
            },
            child: const Icon(Icons.add)));
  }
}
