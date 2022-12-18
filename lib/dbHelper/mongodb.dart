import 'dart:developer';
// import 'dart:html';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:tusgrupos/dbHelper/constant.dart';
import 'package:tusgrupos/models/comments_model.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/inscripciones_model.dart';
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

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    users = db.collection(USER_COLLECTION);
    groups = db.collection(GROUP_COLLECTION);
    inscriptions = db.collection(INSCRIPTIONS_COLLECTION);
    comments = db.collection(COMMENTS_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getGrupos() async {
    final arrData = await groups.find().toList();
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getGruposQuery() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('emailUser');
    final arrData = await groups.find(where.eq('owner', email)).toList();
    //print("Buscando" + email.toString() + "En Mongo");
    return arrData;
  }

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

  static Future<bool> checkUser(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = await users.findOne(where.eq('email', email));

    // var userID = res['_id'].toString();
    // print(typeof userID);
    // prefs.setString('userId', userID);
    // print(prefs.getString('userId'));

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

  // static Future<userModel> getUser(String email) async {
  //   var res = await users.find(where.eq('email', email)).first;

  //   if (res is userModel) {
  //     print("Es un usuario");
  //   }

  //   return res;
  // }

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

  static Future<String> inscribeUser(groupModel group) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userEmail = prefs.getString('userEmail');
    // print(userEmail);
    var user = await users.findOne(where.eq('email', userEmail));
    var data = user['_id'].$oid.toString();
    ObjectId userId = ObjectId.fromHexString(data);
    ObjectId groupId = group.id;

    // print(userId);
    // print(groupId);

    if (inscriptions.find(where.eq('user', userId).eq('group', groupId)) !=
        null) {
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

  static Future<List<Map<String, dynamic>>> getComments() async {
    final arrData = await comments.find().toList();
    return arrData;
  }

  // static Future<List<Map<String, dynamic>>> getOwnedGroups(
  //     String owner) async {
  //   var res = await groups.find(where.eq('owner', owner)).toList();
  //   // print(res);
  //   return res;
  // }
}
