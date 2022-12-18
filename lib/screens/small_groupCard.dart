import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mongo_dart/mongo_dart.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
// import 'package:tusgrupos/models/inscripciones_model.dart';

class SmallGroupCard extends StatelessWidget {
  const SmallGroupCard({Key? key, required this.group}) : super(key: key);
  final groupModel group;

  BuildContext? get context => null;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      initialPadding: const EdgeInsets.all(10),
      baseColor: const Color.fromARGB(143, 217, 85, 160),
      expandedColor: const Color.fromARGB(255, 81, 139, 187),
      expandedTextColor: const Color.fromARGB(255, 41, 8, 106),
      title: Text(group.Name,
          style: const TextStyle(
            fontSize: 20,
          )),
      subtitle: Text(group.Description),
      children: <Widget>[
        const Divider(thickness: 1.0, height: 1.0),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ))),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () => _unirse(group),
              child: Row(
                children: const <Widget>[
                  Text('Unirse'),
                  Icon(Icons.add),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _unirse(groupModel grupo) async {
    // ignore: unused_local_variable
    var res = await MongoDatabase.inscribeUser(grupo);
    ScaffoldMessenger.of(context!).showSnackBar(
      const SnackBar(
        content: Text('Te has unido al grupo'),
      ),
    );
  }
}
