import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/crear_grupo_screen.dart';

class GruposCreadosScreen extends StatefulWidget {
  @override
  State<GruposCreadosScreen> createState() => _GruposCreadosScreenState();
}

class _GruposCreadosScreenState extends State<GruposCreadosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 190, 173, 185),
      appBar: AppBar(
        title: Text('Grupos Creados'),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add_rounded),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateGroup()));
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Grupos Creados'),
      ),
    );
  }
}
