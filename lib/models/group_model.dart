// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tusgrupos/models/user_model.dart';

groupModel groupModelFromJson(String str) =>
    groupModel.fromJson(json.decode(str));

String groupModelToJson(groupModel data) => json.encode(data.toJson());

// ignore: camel_case_types
class groupModel {
  groupModel(
      {required this.Id,
      required this.Owner,
      required this.Name,
      required this.Description,
      required this.Admin,
      required this.Members,
      required this.password});

  ObjectId Id;
  userModel Owner;
  String Name;
  String Description;
  String Admin;
  List<String> Members;
  String password;

  factory groupModel.fromJson(Map<String, dynamic> json) => groupModel(
        Id: json["id"],
        Owner: json["owner"],
        Name: json["nombre"],
        Description: json["descripcion"],
        Admin: json["admin"],
        Members: json["miembros"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": Id,
        "owner": Owner,
        "nombre": Name,
        "descripcion": Description,
        "admin": Admin,
        "miembros": Members,
        "password": password,
      };
}
