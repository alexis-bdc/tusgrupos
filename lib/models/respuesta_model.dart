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
    required this.OwnerName,
    required this.Group,
    required this.Comment,
    required this.Date,
  });

  ObjectId id;
  ObjectId Hilo;
  String Owner;
  String OwnerName;
  ObjectId Group;
  String Comment;
  DateTime Date;

  factory respuestaModel.fromJson(Map<String, dynamic> json) => respuestaModel(
        id: json["_id"],
        Hilo: json["hilo"],
        Owner: json["owner"],
        OwnerName: json["ownerName"],
        Group: json["group"],
        Comment: json["comment"],
        Date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "hilo": Hilo,
        "owner": Owner,
        "ownerName": OwnerName,
        "group": Group,
        "comment": Comment,
        "date": Date,
      };
}
