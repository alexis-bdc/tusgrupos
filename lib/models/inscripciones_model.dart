import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:tusgrupos/dbHelper/mongodb.dart';
import 'package:tusgrupos/models/group_model.dart';
import 'package:tusgrupos/models/user_model.dart';

inscripcionesModel inscripcionesModelFromJson(String str) =>
    inscripcionesModel.fromJson(json.decode(str));

String inscripcionesModelToJson(inscripcionesModel data) =>
    json.encode(data.toJson());

class inscripcionesModel {
  inscripcionesModel(
      {required this.User,
      required this.Group,
      required this.EntryDate,
      this.ExitDate});

  ObjectId User;
  ObjectId Group;
  DateTime EntryDate;
  DateTime? ExitDate;

  factory inscripcionesModel.fromJson(Map<String, dynamic> json) =>
      inscripcionesModel(
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

  static Future<String> inscribeUser(groupModel group) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userEmail = prefs.getString('userEmail');

    ObjectId userId = await userModel.getUserId(userEmail!);
    ObjectId groupId = group.id;

    var temp = await MongoDatabase.inscriptions
        .findOne({'_iduser': userId, '_idgroup': groupId});

    if (temp != null) {
      return 2.toString(); //Ya está inscrito
    } else {
      final inscripcion = inscripcionesModel(
          User: userId, Group: groupId, EntryDate: DateTime.now());
      try {
        var res =
            await MongoDatabase.inscriptions.insertOne(inscripcion.toJson());
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

  static Future<List> getParticipantesQuery(ObjectId grupoId) async {
    var arrInscriptions = await MongoDatabase.inscriptions
        .find(where.eq('_idgroup', grupoId))
        .toList();
    //print("Buscando" + email.toString() + "En Mongo");

    List arrUsers = [];
    for (var index = 0; index < arrInscriptions.length; index++) {
      arrUsers.add(await MongoDatabase.users
          .findOne(where.eq('_id', arrInscriptions[index]['_iduser'])));
      //await groups.find(where.eq('id', arrInscriptions['id'].toString()));
    }

    return arrUsers;
  }

  static Future<bool> isUserInscribed(groupModel grupo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    ObjectId userId = await userModel.getUserId(userEmail!);

    var res = await MongoDatabase.inscriptions
        .findOne({'_iduser': userId, '_idgroup': grupo.id});

    if (res != null) {
      return true;
    } else {
      return false;
    }
  }
}
