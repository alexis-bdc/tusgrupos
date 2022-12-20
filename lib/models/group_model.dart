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
}
