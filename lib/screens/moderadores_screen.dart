import 'package:flutter/material.dart';

import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/moderador_model.dart';
import 'package:tusgrupos/models/user_model.dart';

import 'package:mongo_dart/mongo_dart.dart' as M;

class ModeradoresScreen extends StatelessWidget {
  final groupModel grupo;

  const ModeradoresScreen({Key? key, required this.grupo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 58, 100),
        title: Text(grupo.Name),
      ),
      body: FutureBuilder(
        future: moderadorModel.getModeradoresQuery(grupo.id),
        //initialData: InitialData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
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
                        onTap: () => {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Quitar de Moderadores?'),
                              icon: Icon(Icons.remove_moderator_outlined),
                              iconColor: Colors.red,
                              actions: [
                                TextButton(
                                    onPressed: () async => {
                                          print(await moderadorModel.deleteMod(
                                              userModel
                                                  .fromJson(
                                                      snapshot.data![index])
                                                  .id,
                                              grupo)),
                                          Navigator.pop(context),
                                          Navigator.pop(context),
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ModeradoresScreen(
                                                      grupo: grupo),
                                            ),
                                          ),
                                        },
                                    child: const Text("Aceptar")),
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Volver"))
                              ],
                            ),
                          ),
                        },
                        child: ListTile(
                          leading: const Icon(
                            Icons.security_outlined,
                            color: Colors.purple,
                          ),
                          trailing: const Icon(Icons.remove_circle_outline,
                              color: Colors.purple),
                          title: Text(
                              userModel.fromJson(snapshot.data![index]).Name),
                        ),
                      ));
            } else {
              return const Center(
                child: Text("No data available."),
              );
            }
          }
        },
      ),
    );
  }
}
