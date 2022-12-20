import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:tusgrupos/dbHelper/constant.dart';
import 'package:tusgrupos/models/comments_model.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/inscripciones_model.dart';
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

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    users = db.collection(USER_COLLECTION);
    groups = db.collection(GROUP_COLLECTION);
    inscriptions = db.collection(INSCRIPTIONS_COLLECTION);
    comments = db.collection(COMMENTS_COLLECTION);
    respuestas = db.collection(RESPUESTAS_COLLECTION);
  }

  //----------------------------inserciones-------------------------------------

  static Future<String> insertUser(userModel user) async {
    try {
      // return await userCollection.insert(user.toJson());
      var result = await users.insertOne(user.toJson());
      if (result.isSuccess) {
        // print(user);
        return "Success";
      } else {
        return "Error";
      }
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insertGroup(groupModel group) async {
    try {
      // return await userCollection.insert(user.toJson());
      var result = await groups.insertOne(group.toJson());
      if (result.isSuccess) {
        // print(group);
        return "Success";
      } else {
        return "Error";
      }
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  static Future<String> inscribeUser(groupModel group) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userEmail = prefs.getString('userEmail');

    ObjectId userId = await getUserId(userEmail!);
    ObjectId groupId = group.id;

    var temp =
        await inscriptions.findOne({'_iduser': userId, '_idgroup': groupId});

    if (temp != null) {
      return 2.toString(); //Ya está inscrito
    } else {
      final inscripcion = inscripcionesModel(
          User: userId, Group: groupId, EntryDate: DateTime.now());
      try {
        var res = await inscriptions.insertOne(inscripcion.toJson());
        if (res.isSuccess) {
          return 1.toString(); //Inscripción exitosa
        } else {
          return 0.toString(); //Error
        }
      } catch (e) {
        return e.toString();
      }
    }
  }

  static Future<String> insertComment(commentModel comment) async {
    try {
      // return await userCollection.insert(user.toJson());
      var result = await comments.insertOne(comment.toJson());
      if (result.isSuccess) {
        // print(group);
        return "Success";
      } else {
        return "Error";
      }
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insertRespuesta(respuestaModel respuesta) async {
    try {
      // return await userCollection.insert(user.toJson());
      var result = await respuestas.insertOne(respuesta.toJson());
      if (result.isSuccess) {
        // print(group);
        return "Success";
      } else {
        return "Error";
      }
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  //-----------------------------Consultas--------------------------------------

  static Future<ObjectId> getUserId(String email) async {
    var res = await users.findOne(where.eq('email', email));
    return res['_id'];
  }

  static Future<Map<String, dynamic>> getUser(String email) async {
    var res = await users.findOne(where.eq('email', email));
    return res;
  }

  // static Future<List<Map<String, dynamic>>> getGruposQuery() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? email = prefs.getString('userEmail');
  //   // print("Querying with email: " + email.toString());
  //   final arrData = await groups.find(where.eq('owner', email)).toList();
  //   //print("Buscando" + email.toString() + "En Mongo");
  //   return arrData;
  // }

  static Future<bool> checkUser(String email, String password) async {
    var res = await users.findOne(where.eq('email', email));

    if (res != null) {
      if (res['password'] == password) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> searchGroups(
    String string,
  ) async {
    if (string == '') {
      var res = await groups.find().toList();
      return res;
    } else {
      var res = await groups.find({
        'nombre': {
          r'$regex': string,
          r'$options': 'i',
        }
      }).toList();
      return res;
    }
  }

  static Future<List<Map<String, dynamic>>> getComments() async {
    final arrData = await comments.find().toList();
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getCommentsQuery(
      groupModel grupo) async {
    final arrData = await comments.find(where.eq('group', grupo.id)).toList();
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getResponsesQuery(
      commentModel hilo, groupModel grupo) async {
    final arrData = await respuestas.find(where.eq('hilo', hilo.id)).toList();
    return arrData;
  }

  static Future<List> getCreadosQuery() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('userEmail');

    ObjectId userId = await getUserId(email!);

    var grupos = await groups.find(where.eq('_idowner', userId)).toList();

    return grupos;
    // var arrInscriptions =
    //     await inscriptions.find(where.eq('_iduser', userId)).toList();

    // List arrData = [];
    // for (var index = 0; index < arrInscriptions.length; index++) {
    //   arrData.add(await groups
    //       .findOne(where.eq('_id', arrInscriptions[index]['_idgroup'])));
    // }

    // return arrData;
  }

  static Future<List> participantGroups(ObjectId userId) async {
    List temp = await inscriptions.find(where.eq('_iduser', userId)).toList();
    List temp2 = [];
    for (var i = 0; i < temp.length; i++) {
      temp2.add(await groups.findOne(where.eq('_id', temp[i]['_idgroup'])));
    }
    return temp2;
  }

  //------------------------------Updates---------------------------------------

  //------------------------------Deletes---------------------------------------

}
