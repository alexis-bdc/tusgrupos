import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/screens/ajustes_grupo_screen.dart';
import 'package:tusgrupos/screens/crear_grupo_screen.dart';
import 'package:tusgrupos/screens/grupos_card.dart';

class GruposCreadosScreen extends StatefulWidget {
  @override
  State<GruposCreadosScreen> createState() => _GruposCreadosScreenState();
}

class _GruposCreadosScreenState extends State<GruposCreadosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 190, 173, 185),
      appBar: AppBar(
        title: const Text('Grupos Creados'),
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
        leading: const Icon(Icons.co_present_outlined),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add_rounded),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateGroup()));
            },
          ),
        ],
      ),

      // body: ListView.builder(
      //     itemBuilder: (BuildContext context, int index) {
      //     }),
      body: FutureBuilder(
        future: MongoDatabase.getInscripcionesQuery(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var totalData = snapshot.data?.length;
              print("total Data" + totalData.toString());
              return ListView.builder(
                itemCount: totalData,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AjustesGrupoScreen(
                                    grupo: groupModel
                                        .fromJson(snapshot.data![index])),
                              ),
                            ),
                        child: GruposCard(
                          grupo: groupModel.fromJson(snapshot.data![index]),
                        )),
              );
            } else {
              return Center(
                child: Text("No data available."),
              );
            }
          }
        },
      ),
    );
  }
}