import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/grupos_card.dart';

class VerMisGrupos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Mis grupos'),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) => GruposCard()),
    );
  }
}
