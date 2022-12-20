import 'package:flutter/material.dart';
// import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
// import 'package:tusgrupos/models/group_model.dart';

class MisGruposScreen extends StatefulWidget {
  const MisGruposScreen({Key? key}) : super(key: key);

  @override
  _MisGruposScreenState createState() => _MisGruposScreenState();
}

class _MisGruposScreenState extends State<MisGruposScreen> {
  var _child;

  Future<List> getGroups() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    var userId = await MongoDatabase.getUserId(userEmail!);
    var groups = await MongoDatabase.participantGroups(userId);

    return groups;
  }

  Future<Widget> __body(groupModel grupo) async {
    return Container(
      child: Text(grupo.Name),
    );
  }

  @override
  Widget initState() {
    super.initState();
    return _child = const Center(
        child: Text('Mis Grupos',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Grupos'),
      ),
      body: _child,
    );
  }
}
