import 'package:flutter/material.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/comments_model.dart';
import 'package:tusgrupos/screens/crear_hilo_screen.dart';
import 'package:tusgrupos/screens/hilo_screen.dart';

class HilosScreen extends StatelessWidget {
  final groupModel grupo;

  const HilosScreen({Key? key, required this.grupo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
        title: Text('Hilos - ${grupo.Name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment_rounded),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CrearHilo(grupo: grupo)));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: commentModel.getCommentsQuery(grupo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var totalData = snapshot.data?.length;
              //print("total Data" + totalData.toString());
              return ListView.builder(
                itemCount: totalData,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HiloScreen(
                          hilo: commentModel.fromJson(snapshot.data![index]),
                          grupo: grupo),
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.forum_outlined,
                      color: Colors.purple,
                    ),
                    title: Text(
                        commentModel.fromJson(snapshot.data![index]).Title),
                    subtitle: Text(
                        commentModel.fromJson(snapshot.data![index]).OwnerName),
                    trailing: const Icon(Icons.arrow_forward,
                        color: Colors.pinkAccent),
                  ),
                ),
              );
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
