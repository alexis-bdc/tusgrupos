import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:tusgrupos/dbHelper/constant.dart';
import 'package:tusgrupos/models/user_model.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<void> insert() async {
    try {} catch (e) {
      print(e.toString());
    }
  }

  static Future<String> insertUser(userModel user) async {
    try {
      // return await userCollection.insert(user.toJson());
      var result = await userCollection.insertOne(user.toJson());
      if (result.isSuccess) {
        return "Usuario registrado con éxito";
      } else {
        return "Error al registrar usuario";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
