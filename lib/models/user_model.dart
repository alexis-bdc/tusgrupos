// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

import 'package:tusgrupos/dbHelper/mongodb.dart';

userModel userModelFromJson(String str) => userModel.fromJson(json.decode(str));

String userModelToJson(userModel data) => json.encode(data.toJson());

// ignore: camel_case_types
class userModel {
  userModel({
    required this.id,
    required this.Name,
    // required this.LastName,
    required this.Email,
    required this.Password,
  });

  ObjectId id;
  String Name;
  // String LastName;
  String Email;
  String Password;

  factory userModel.fromJson(Map<String, dynamic> json) => userModel(
        id: json["_id"],
        Name: json["nombre"],
        // LastName: json["apellido"],
        Email: json["email"],
        Password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": Name,
        // "apellido": LastName,
        "email": Email,
        "password": Password,
      };

  static Future<String> insertUser(userModel user) async {
    try {
      // return await userCollection.insert(user.toJson());
      var result = await MongoDatabase.users.insertOne(user.toJson());
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

  static Future<ObjectId> getUserId(String email) async {
    var res = await MongoDatabase.users.findOne(where.eq('email', email));
    return res['_id'];
  }

  static Future<Map<String, dynamic>> getUser(String email) async {
    var res = await MongoDatabase.users.findOne(where.eq('email', email));
    return res;
  }

  static Future<bool> checkUser(String email, String password) async {
    var res = await MongoDatabase.users.findOne(where.eq('email', email));

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
}
