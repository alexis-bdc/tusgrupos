import 'package:flutter/material.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/screens/grupos_card.dart';

class GrupoScreen extends StatelessWidget {
  final groupModel grupo;
  const GrupoScreen({Key? key, required this.grupo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 58, 100),
        title: Text('${grupo.Name}'),
      ),
      body: ListView(
        children: [
          GruposCard(grupo: grupo),
        ],
      ),
    );
  }
}
