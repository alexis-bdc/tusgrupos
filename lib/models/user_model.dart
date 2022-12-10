// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

userModel userModelFromJson(String str) => userModel.fromJson(json.decode(str));

String userModelToJson(userModel data) => json.encode(data.toJson());

// ignore: camel_case_types
class userModel {
  userModel({
    required this.Id,
    required this.Email,
    required this.Name,
    required this.LastName,
    required this.Password,
  });

  ObjectId Id;
  String Name;
  String LastName;
  String Email;
  String Password;

  factory userModel.fromJson(Map<String, dynamic> json) => userModel(
        Id: json["id"],
        Name: json["nombre"],
        LastName: json["apellido"],
        Email: json["email"],
        Password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": Id,
        "nombre": Name,
        "apellido": LastName,
        "email": Email,
        "password": Password,
      };
}
