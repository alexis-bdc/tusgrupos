// ignore_for_file: camel_case_types

import 'package:mongo_dart/mongo_dart.dart';
import 'dart:convert';

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
}
