// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:tusgrupos/models/group_model.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:tusgrupos/models/inscripciones_model.dart';
import 'package:tusgrupos/screens/grupos_card.dart';

class SmallGroupCard extends StatelessWidget {
  SmallGroupCard({Key? key, required this.group});
  final groupModel group;
  var keycontroller = TextEditingController(text: '');

  //todo: cambio vista a grupo especifico

  @override
  Widget build(BuildContext context) {
    Widget _key = TextFormField(
      controller: keycontroller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: const Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // contentPadding: const EdgeInsets.fromLTRB(1.0, 10.0, 20.0, 10.0),
        // hintText: 'clave',
        constraints: const BoxConstraints(
          maxHeight: 50,
          maxWidth: 250,
        ),
      ),
    );

    Future<void> _unirse(groupModel grupo, String password) async {
      // ignore: unused_local_variable

      if (password == grupo.password) {
        var res = await inscripcionesModel.inscribeUser(grupo);
        switch (int.parse(res)) {
          case 0:
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text('Errow inesperado!'),
                      icon: Icon(Icons.error),
                      iconColor: Colors.red,
                    ));
            break;
          case 1:
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text('Inscrito con exito!'),
                      icon: Icon(Icons.check),
                      iconColor: Colors.green,
                    ));
            break;
          case 2:
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text('Ya estas Inscrito!'),
                      icon: Icon(Icons.tag_faces),
                      iconColor: Colors.green,
                    ));
            break;
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text('Clave incorrecta!'),
                  icon: Icon(Icons.close),
                  iconColor: Colors.red,
                ));
      }
    }

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
        _key,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () => _unirse(group, keycontroller.text),
                  child: Row(
                    children: const <Widget>[
                      Text('Unirse'),
                      Icon(Icons.add),
                    ],
                  ),
                ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () {},
                  child: Row(
                    children: const <Widget>[
                      Text('Ver Grupo'),
                      Icon(Icons.forward),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class participationCard extends StatelessWidget {
  const participationCard({super.key, required this.group});
  final groupModel group;

  @override
  Widget build(BuildContext context) {
    return GruposCard(grupo: group);
  }
}
