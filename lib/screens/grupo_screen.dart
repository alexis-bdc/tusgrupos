import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/grupos_card.dart';

class GrupoScreen extends StatelessWidget {
  const GrupoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Nombre Grupo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //GruposCard(),
          ],
        ),
      ),
    );
  }
}
