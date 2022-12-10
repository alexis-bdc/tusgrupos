import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:tusgrupos/dbHelper/constant.dart';
import 'package:tusgrupos/models/user_model.dart';

class MongoDatabase {
  static var db;
  static var users;
  static var groups;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    users = db.collection(USER_COLLECTION);
    groups = db.collection(GROUP_COLLECTION);
  }

  static Future<void> insert() async {
    try {} catch (e) {
      print(e.toString());
    }
  }

  static Future<String> insertUser(userModel user) async {
    try {
      // return await userCollection.insert(user.toJson());
      var result = await users.insertOne(user.toJson());
      if (result.isSuccess) {
        print(user);
        return "Success";
      } else {
        return "Error";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
