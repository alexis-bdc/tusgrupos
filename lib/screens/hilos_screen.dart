import 'package:flutter/material.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/screens/crear_hilo_screen.dart';
import 'package:tusgrupos/screens/grupos_card.dart';

class HilosScreen extends StatelessWidget {
  final groupModel grupo;
  final options = const [
    'Hilos',
    'Detalles',
    'Participantes',
  ];
  final iconos = const [
    Icons.add_comment_rounded,
    Icons.description_rounded,
    Icons.person
  ];
  const HilosScreen({Key? key, required this.grupo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 58, 100),
        title: Text('Hilos - ${grupo.Name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment_rounded),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CrearHilo(grupo: grupo)));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          //GruposCard(grupo: grupo),

          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(
                iconos[index],
                color: Colors.purple,
              ),
              title: Text(options[index]),
              trailing:
                  const Icon(Icons.arrow_forward, color: Colors.pinkAccent),
              onTap: () => () {},
            ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: 3,
          ),
        ],
      ),
    );
  }
}
