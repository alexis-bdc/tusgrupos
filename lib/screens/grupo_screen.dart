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
        backgroundColor: Colors.orange,
        title: Text('${grupo.Name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [GruposCard(grupo: grupo)],
        ),
      ),
    );
  }
}
