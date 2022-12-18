import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/screens/crear_grupo_screen.dart';
import 'package:tusgrupos/screens/small_groupCard.dart';

class GruposCreadosScreen extends StatefulWidget {
  @override
  State<GruposCreadosScreen> createState() => _GruposCreadosScreenState();
}

class _GruposCreadosScreenState extends State<GruposCreadosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 190, 173, 185),
      appBar: AppBar(
        title: const Text('Grupos Creados'),
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
      ),
      // body: ListView.builder(
      //     itemBuilder: (BuildContext context, int index) {
      //     }),
    );
  }
}
