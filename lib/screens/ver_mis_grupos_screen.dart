import 'package:flutter/material.dart';
import 'package:tusgrupos/screens/grupo_screen.dart';
import 'package:tusgrupos/screens/grupos_card.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class VerMisGrupos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 190, 173, 185),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 58, 100),
        title: Text('Mis grupos'),
      ),
      body: FutureBuilder(
        future: MongoDatabase.getGruposQuery(),
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
                    GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GrupoScreen(
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

  Future<String> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('emailUser');
    //print(email);
    //setState(() => _userEmail = email);
    return email!;
  }
}
