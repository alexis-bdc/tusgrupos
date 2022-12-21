import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:tusgrupos/dbHelper/constant.dart';
import 'package:tusgrupos/models/comments_model.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/inscripciones_model.dart';
import 'package:tusgrupos/models/moderador_model.dart';
import 'package:tusgrupos/models/respuesta_model.dart';
import 'package:tusgrupos/models/user_model.dart';
// import 'package:tusgrupos/models/comments_model.dart';
// import 'package:tusgrupos/models/files_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MongoDatabase {
  static var db;
  static var users;
  static var groups;
  static var inscriptions;
  static var comments;
  static var respuestas;
  static var moderadores;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    users = db.collection(USER_COLLECTION);
    groups = db.collection(GROUP_COLLECTION);
    inscriptions = db.collection(INSCRIPTIONS_COLLECTION);
    comments = db.collection(COMMENTS_COLLECTION);
    respuestas = db.collection(RESPUESTAS_COLLECTION);
    moderadores = db.collection(MODERADORES_COLLECTION);
  }

  //----------------------------inserciones-------------------------------------

  //-----------------------------Consultas--------------------------------------

  // static Future<List<Map<String, dynamic>>> getGruposQuery() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? email = prefs.getString('userEmail');
  //   // print("Querying with email: " + email.toString());
  //   final arrData = await groups.find(where.eq('owner', email)).toList();
  //   //print("Buscando" + email.toString() + "En Mongo");
  //   return arrData;
  // }

  // static Future<List<Map<String, dynamic>>> getComments() async {
  //   final arrData = await comments.find().toList();
  //   return arrData;
  // }

//  static Future<List> getParticipantesNoModsQuery(ObjectId grupoId) async {
//    var arrInscriptions =
//        await inscriptions.find(where.eq('_idgroup', grupoId)).toList();
//    //print("Buscando" + email.toString() + "En Mongo");
//
//    List arrUsers = [];
//    for (var index = 0; index < arrInscriptions.length; index++) {
//      print(arrInscriptions[index]['_iduser']);
//      if (!(await isMod(arrInscriptions[index]['_iduser'], grupoId)))
//        arrUsers.add(await users
//            .findOne(where.eq('_id', arrInscriptions[index]['_iduser'])));
//      print("Inscripciones encontradas" + index.toString());
//    }
//    //await groups.find(where.eq('id', arrInscriptions['id'].toString()));
//
//    return arrUsers;
//  }

  //------------------------------Updates---------------------------------------

  //------------------------------Deletes---------------------------------------
}
