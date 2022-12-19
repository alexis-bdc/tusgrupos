import 'package:flutter/material.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/comments_model.dart';
import 'package:tusgrupos/screens/crear_hilo_screen.dart';
import 'package:tusgrupos/screens/grupo_screen.dart';
import 'package:tusgrupos/screens/grupos_card.dart';

class HiloScreen extends StatelessWidget {
  final commentModel hilo;

  const HiloScreen({Key? key, required this.hilo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 120, 58, 100),
        title: Text('Hilos - ${hilo.Title}'),
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
        future: MongoDatabase.getResponsesQuery(hilo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var totalData = snapshot.data?.length;
              //print("total Data" + totalData.toString());
              return ListView.builder(
                itemCount: totalData,
                itemBuilder: (BuildContext context, int index) =>
//                   GestureDetector(
//                  onTap: () => Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => GrupoScreen(
//                          grupo: groupModel.fromJson(snapshot.data![index])),
//                    ),
//                  ),
                    ListTile(
                  leading: Icon(
                    Icons.forum_outlined,
                    color: Colors.purple,
                  ),
                  title:
                      Text(commentModel.fromJson(snapshot.data![index]).Title),
                  //trailing: const Icon(Icons.arrow_forward,
                  //    color: Colors.pinkAccent),
                  subtitle: Text(
                      commentModel.fromJson(snapshot.data![index]).Comment),
                ),
//                ),
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
