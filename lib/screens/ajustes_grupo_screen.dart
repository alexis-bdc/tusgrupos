import 'package:flutter/material.dart';

import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/screens/editar_grupo_screen.dart';
import 'package:tusgrupos/screens/moderadores_screen.dart';
import 'package:tusgrupos/screens/participantes_screen.dart';

class AjustesGrupoScreen extends StatelessWidget {
  final groupModel grupo;
  final options = const [
    'Editar Información',
    'Eliminar Moderador',
    'Designar Moderador',
    'Eliminar Participante',
  ];
  final iconos = const [
    Icons.info_outline_rounded,
    Icons.security_rounded,
    Icons.person,
    Icons.delete_outline_outlined
  ];

  const AjustesGrupoScreen({Key? key, required this.grupo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
        title: Text(grupo.Name),
      ),
      body: Column(
        children: [
          //GruposCard(grupo: grupo),
          const Image(image: AssetImage('assets/default_group.jpg')),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(
              iconos[0],
              color: Colors.purple,
            ),
            title: Text(options[0]),
            trailing: const Icon(Icons.arrow_forward, color: Colors.pinkAccent),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditarGrupo(
                  grupo: grupo,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              iconos[1],
              color: Colors.purple,
            ),
            title: Text(options[1]),
            trailing: const Icon(Icons.arrow_forward, color: Colors.pinkAccent),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ModeradoresScreen(
                  grupo: grupo,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              iconos[2],
              color: Colors.purple,
            ),
            title: Text(options[2]),
            trailing: const Icon(Icons.arrow_forward, color: Colors.pinkAccent),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ParticipantesScreen(
                  grupo: grupo,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
              leading: Icon(
                iconos[3],
                color: Colors.purple,
              ),
              title: Text(options[3]),
              trailing:
                  const Icon(Icons.arrow_forward, color: Colors.pinkAccent),
              onTap: () => {}),
        ],
      ),
    );
  }
}
