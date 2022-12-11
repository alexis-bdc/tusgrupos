// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

userModel userModelFromJson(String str) => userModel.fromJson(json.decode(str));

String userModelToJson(userModel data) => json.encode(data.toJson());

// ignore: camel_case_types
class userModel {
  userModel({
    required this.id,
    required this.Name,
    required this.LastName,
    required this.Email,
    required this.Password,
  });

  ObjectId id;
  String Name;
  String LastName;
  String Email;
  String Password;

  factory userModel.fromJson(Map<String, dynamic> json) => userModel(
        id: json["_id"],
        Name: json["nombre"],
        LastName: json["apellido"],
        Email: json["email"],
        Password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": Name,
        "apellido": LastName,
        "email": Email,
        "password": Password,
      };
}
