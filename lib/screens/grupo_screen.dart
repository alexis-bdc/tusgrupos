import 'package:flutter/material.dart';
// import 'package:tusgrupos/dbHelper/mongodb.dart';
// import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/comments_model.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/inscripciones_model.dart';
import 'package:tusgrupos/screens/crear_hilo_screen.dart';
import 'package:tusgrupos/screens/hilo_screen.dart';
// import 'package:tusgrupos/screens/participacion_grupo_screen.dart';
// import 'package:tusgrupos/screens/participantes_screen.dart';

class GrupoScreen extends StatelessWidget {
  GrupoScreen({super.key, required this.group});
  groupModel group;

  @override
  Widget build(BuildContext context) {
    listhilos(groupModel Group) {
      return FutureBuilder(
        future: commentModel.getCommentsQuery(Group),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var totalData = snapshot.data?.length;
              return ListView.builder(
                itemCount: totalData,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  child: hiloCard(commentModel.fromJson(snapshot.data![index])),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HiloScreen(
                            hilo: commentModel.fromJson(snapshot.data![index]),
                            grupo: Group)),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('No hay hilos'),
              );
            }
          }
        },
      );
    }

    verificaInscripcion(groupModel Group) async {
      var res = await inscripcionesModel.isUserInscribed(Group);
      return res;
    }

    _body() {
      // ignore: unrelated_type_equality_checks
      if (verificaInscripcion(group) == true) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 350),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(143, 158, 0, 89),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: const Color.fromARGB(255, 208, 46, 138),
                  width: 2,
                ),
              ),
              child: Text(
                group.Description,
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: listhilos(group)),
          ],
        );
      } else {
        return const Center(child: Text('No estas inscrito en este grupo'));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
        title: Text(group.Name),
        actions: [
          IconButton(
              icon: const Icon(Icons.add_comment_rounded),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CrearHilo(grupo: group)));
              })
        ],
      ),
      body: _body(),
    );
  }
}

class hiloCard extends StatelessWidget {
  hiloCard(this.hilo);
  commentModel hilo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.forum_outlined,
          color: Colors.purple,
        ),
        title: Text(hilo.Title),
        subtitle: Text('${hilo.Owner} - ${hilo.Date}'),
      ),
    );
  }
}
