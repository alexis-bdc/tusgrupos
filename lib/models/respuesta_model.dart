// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

respuestaModel respuestaModelFromJson(String str) =>
    respuestaModel.fromJson(json.decode(str));

String respuestaModelToJson(respuestaModel data) => json.encode(data.toJson());

// ignore: camel_case_types
class respuestaModel {
  respuestaModel({
    required this.id,
    required this.Hilo,
    required this.Owner,
    required this.Group,
    required this.Comment,
    required this.Date,
  });

  ObjectId id;
  ObjectId Hilo;
  String Owner;
  ObjectId Group;
  String Comment;
  DateTime Date;

  factory respuestaModel.fromJson(Map<String, dynamic> json) => respuestaModel(
        id: json["_id"],
        Hilo: json["hilo"],
        Owner: json["owner"],
        Group: json["group"],
        Comment: json["comment"],
        Date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "hilo": Hilo,
        "owner": Owner,
        "group": Group,
        "comment": Comment,
        "date": Date,
      };
}
