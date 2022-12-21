// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/inscripciones_model.dart';
import 'package:tusgrupos/models/user_model.dart';
import 'package:tusgrupos/screens/grupo_screen.dart';
import 'package:tusgrupos/screens/small_groupCard.dart';
// import 'package:tusgrupos/models/group_model.dart';

class GruposInscritos extends StatefulWidget {
  const GruposInscritos({Key? key}) : super(key: key);

  @override
  _GruposInscritosState createState() => _GruposInscritosState();
}

class _GruposInscritosState extends State<GruposInscritos> {
  // var _child;

  Future<List> getGroups() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    var userId = await userModel.getUserId(userEmail!);
    var groups = await groupModel.participantGroups(userId);

    return groups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 120, 58, 100),
          title: const Text('Grupos Inscritos'),
          leading: const Icon(Icons.group)
          // IconButton(
          //   icon: ,
          //   onPressed: () {},
          // ),
          ),
      body: FutureBuilder(
          future: getGroups(),
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
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GrupoScreen(
                              group:
                                  groupModel.fromJson(snapshot.data![index])),
                        )),
                    child: participationCard(
                      group: groupModel.fromJson(snapshot.data![index]),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text('No hay grupos'),
                );
              }
            }
          }),
    );
  }
}
