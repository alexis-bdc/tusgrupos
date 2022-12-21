// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tusgrupos/dbHelper/mongodb.dart';

import 'package:tusgrupos/models/user_model.dart';

groupModel groupModelFromJson(String str) =>
    groupModel.fromJson(json.decode(str));

String groupModelToJson(groupModel data) => json.encode(data.toJson());

// ignore: camel_case_types
class groupModel {
  groupModel(
      {required this.id,
      this.idOwner,
      required this.OwnerName,
      required this.Name,
      required this.Description,
      required this.password});

  ObjectId id;
  ObjectId? idOwner;
  String? OwnerName;
  String Name;
  String Description;
  // String Admin;
  // List<String> Members;
  String password;

  factory groupModel.fromJson(Map<String, dynamic> json) => groupModel(
        id: json["_id"],
        idOwner: json["_idowner"],
        OwnerName: json["ownerName"],
        Name: json["nombre"],
        Description: json["descripcion"],
        // Admin: json["admin"],
        // Members: json["miembros"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "_idowner": idOwner,
        "ownerName": OwnerName,
        "nombre": Name,
        "descripcion": Description,
        // "admin": Admin,
        // "miembros": Members,
        "password": password,
      };

  static Future<String> insertGroup(groupModel group) async {
    try {
      // return await userCollection.insert(user.toJson());
      var result = await MongoDatabase.groups.insertOne(group.toJson());
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

  static Future<List<Map<String, dynamic>>> searchGroups(
    String string,
  ) async {
    if (string == '') {
      var res = await MongoDatabase.groups.find().toList();
      return res;
    } else {
      var res = await MongoDatabase.groups.find({
        'nombre': {
          r'$regex': string,
          r'$options': 'i',
        }
      }).toList();
      return res;
    }
  }

  static Future<List> getCreadosQuery() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('userEmail');

    ObjectId userId = await userModel.getUserId(email!);

    var grupos =
        await MongoDatabase.groups.find(where.eq('_idowner', userId)).toList();

    return grupos;
  }

  static Future<List> participantGroups(ObjectId userId) async {
    List temp = await MongoDatabase.inscriptions
        .find(where.eq('_iduser', userId))
        .toList();
    List temp2 = [];
    for (var i = 0; i < temp.length; i++) {
      temp2.add(await MongoDatabase.groups
          .findOne(where.eq('_id', temp[i]['_idgroup'])));
    }
    return temp2;
  }
}
