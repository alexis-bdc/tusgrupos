import 'package:flutter/material.dart';
// import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/screens/small_groupCard.dart';
// import 'package:tusgrupos/models/group_model.dart';

class MisGruposScreen extends StatefulWidget {
  const MisGruposScreen({Key? key}) : super(key: key);

  @override
  _MisGruposScreenState createState() => _MisGruposScreenState();
}

class _MisGruposScreenState extends State<MisGruposScreen> {
  // var _child;

  Future<List> getGroups() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    var userId = await MongoDatabase.getUserId(userEmail!);
    var groups = await MongoDatabase.participantGroups(userId);

    return groups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 120, 58, 100),
          title: const Text('Mis Grupos Inscritos'),
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
