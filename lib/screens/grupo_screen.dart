import 'package:flutter/material.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/screens/hilos_screen.dart';

class GrupoScreen extends StatelessWidget {
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
  const GrupoScreen({Key? key, required this.grupo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 58, 100),
        title: Text('${grupo.Name}'),
      ),
      body: Column(
        children: [
          //GruposCard(grupo: grupo),
          const Image(
              image: NetworkImage(
                  'https://i.kym-cdn.com/photos/images/facebook/002/471/150/78c')),
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
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HilosScreen(
                    grupo: grupo,
                  ),
                ),
              ),
            ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: 3,
          ),
        ],
      ),
    );
  }
}
