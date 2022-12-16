import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/menus.dart';

import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';

import 'package:tusgrupos/screens/grupo_screen.dart';
import 'package:tusgrupos/screens/grupos_card.dart';

class BuscarGrupo extends StatefulWidget {
  const BuscarGrupo({super.key});

  @override
  _BuscarState createState() => _BuscarState();
}

class _BuscarState extends State<BuscarGrupo> {
  Widget? _child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 146, 183),
      //--------------------appbar--------------------
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
        title: const Text('Buscar Grupo'),
      ),

      //--------------------body--------------------
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Nombre',
                    prefixIcon: Icon(Icons.group),
                    prefixIconColor: Color.fromARGB(255, 63, 3, 43),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Dueño',
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Color.fromARGB(255, 63, 3, 43),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 63, 3, 43),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 10),
                  ),
                  onPressed: _searchGroup,
                  child: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //--------------------listview--------------------
          ],
        ),
      ),
    );
  }

  _searchGroup() {}
}
