import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/buscar_grupo_screen.dart';
import 'package:tusgrupos/screens/crear_grup_screen.dart';
import 'package:tusgrupos/screens/inscribir_grupo_screen.dart';
import 'package:tusgrupos/screens/menu_drawer.dart';
import 'package:tusgrupos/screens/crear_hilo_screen.dart';
import 'package:tusgrupos/screens/responder_hilo_screen.dart';

class ParticipacionGrupos extends StatelessWidget {
  const ParticipacionGrupos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //--------------------appbar--------------------
        appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const Text("Participación Grupos"),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InscribirGrupo()),
                  );
                },
                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    elevation: 12.0,
                    textStyle: const TextStyle(color: Colors.orange)),
                child: const Text('Inscribir Grupo'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CrearHilo()),
                  );
                },
                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    elevation: 12.0,
                    textStyle: const TextStyle(color: Colors.orange)),
                child: const Text('Crear Hilo'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResponderHilo()),
                  );
                },
                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    elevation: 12.0,
                    textStyle: const TextStyle(color: Colors.orange)),
                child: const Text('Responder Hilo'),
              ),
            ],
          ),
        ),

        //--------------------floating action button--------------------
        floatingActionButton: FloatingActionButton(
            //todo: conectar a crear grupos
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CreateGroup()));
            },
            child: const Icon(Icons.add)));
  }
}
