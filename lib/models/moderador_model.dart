import 'package:mongo_dart/mongo_dart.dart';
import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'dart:convert';

import 'package:tusgrupos/models/group_model.dart';

moderadorModel moderadorModelFromJson(String str) =>
    moderadorModel.fromJson(json.decode(str));

String moderadorModelToJson(moderadorModel data) => json.encode(data.toJson());

class moderadorModel {
  moderadorModel(
      {required this.User,
      required this.Group,
      required this.EntryDate,
      this.ExitDate});

  ObjectId User;
  ObjectId Group;
  DateTime EntryDate;
  DateTime? ExitDate;

  factory moderadorModel.fromJson(Map<String, dynamic> json) => moderadorModel(
        User: json["_iduser"],
        Group: json["_idgroup"],
        EntryDate: json["entryDate"],
        ExitDate: json["exitDate"],
      );

  Map<String, dynamic> toJson() => {
        "_iduser": User,
        "_idgroup": Group,
        "entryDate": EntryDate,
        "exitDate": ExitDate,
      };

  static Future<String> userToMod(groupModel group, ObjectId userId) async {
    ObjectId groupId = group.id;

    final moderador =
        moderadorModel(User: userId, Group: groupId, EntryDate: DateTime.now());
    try {
      var res = await MongoDatabase.moderadores.insertOne(moderador.toJson());
      if (res.isSuccess) {
        return 1.toString(); //Inscripción exitosa
      } else {
        return 0.toString(); //Error
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<bool> isMod(ObjectId userId, ObjectId grupo) async {
    var res = await MongoDatabase.moderadores
        .findOne({'_iduser': userId, '_idgroup': grupo});

    if (res != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List> getModeradoresQuery(ObjectId grupoId) async {
    var arrModeradores = await MongoDatabase.moderadores
        .find(where.eq('_idgroup', grupoId))
        .toList();
    //print("Buscando" + email.toString() + "En Mongo");

    List arrUsers = [];
    for (var index = 0; index < arrModeradores.length; index++) {
      arrUsers.add(await MongoDatabase.users
          .findOne(where.eq('_id', arrModeradores[index]['_iduser'])));
      //await groups.find(where.eq('id', arrInscriptions['id'].toString()));
    }

    return arrUsers;
  }

  static Future<String> deleteMod(ObjectId userId, groupModel grupo) async {
    ObjectId groupId = grupo.id;
    try {
      // return await userCollection.insert(user.toJson());
      var result = await MongoDatabase.moderadores
          .deleteOne({"_iduser": userId, "_idgroup": groupId});
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
}
