import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:tusgrupos/dbHelper/constant.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/user_model.dart';
// import 'package:tusgrupos/models/comments_model.dart';
// import 'package:tusgrupos/models/files_model.dart';

class MongoDatabase {
  static var db;
  static var users;
  static var groups;
  static var inscriptions;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    users = db.collection(USER_COLLECTION);
    groups = db.collection(GROUP_COLLECTION);
    inscriptions = db.collection(INSCRIPTIONS_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getGrupos() async {
    final arrData = await groups.find().toList();
    return arrData;
  }

  // static Future<void> insert() async {
  //   try {} catch (e) {
  //     print(e.toString());
  //   }
  // }

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

  static Future<bool> findUser(String email, String password) async {
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

  static Future<String> getUserId(String email) async {
    var res = await users.findOne(where.eq('email', email));
    if (res != null) {
      return res['_id'].toString();
    } else {
      return '';
    }
  }

  static Future<List<groupModel>> getGroups(String nombre) async {
    var res = await groups.find(where.eq('nombre', nombre)).tolist();
    return res;
  }
}
