import 'package:flutter/material.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/comments_model.dart';
import 'package:tusgrupos/models/respuesta_model.dart';
import 'package:tusgrupos/screens/crear_hilo_screen.dart';
import 'package:tusgrupos/screens/grupo_screen.dart';
import 'package:tusgrupos/screens/grupos_card.dart';
import 'package:tusgrupos/screens/responder_hilo_screen.dart';

class HiloScreen extends StatelessWidget {
  final commentModel hilo;
  final groupModel grupo;

  const HiloScreen({Key? key, required this.hilo, required this.grupo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 58, 100),
        title: Text(hilo.Title),
//        actions: [
//          IconButton(
//            icon: const Icon(Icons.add_comment_rounded),
//            onPressed: () {
//              Navigator.push(
//                  context,
        //                 MaterialPageRoute(
        //                    builder: (context) => CrearHilo(grupo: grupo)));
        //          },
        //        ),
        //      ],
      ),
      body: FutureBuilder(
        future: MongoDatabase.getResponsesQuery(hilo, grupo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              //print('HAY RESPUESTAS !: ' + snapshot.data!.length.toString());
              var totalData = snapshot.data?.length;
              //print("total Data" + totalData.toString());
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.forum_outlined,
                      color: Colors.purple,
                    ),
                    title: Text(hilo.Title),
                    //trailing: const Icon(Icons.arrow_forward,
                    //    color: Colors.pinkAccent),
                    subtitle: Text(hilo.Comment),
                    trailing: const Icon(Icons.arrow_forward,
                        color: Colors.pinkAccent),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ResponderHilo(hilo: hilo, grupo: grupo),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: totalData,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      leading: Icon(
                        Icons.forum_outlined,
                        color: Colors.purple,
                      ),
                      title: Text(
                          respuestaModel.fromJson(snapshot.data![index]).Owner),
                      subtitle: Text(respuestaModel
                          .fromJson(snapshot.data![index])
                          .Comment),
                    ),
//                ),
                  ),
                ],
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
