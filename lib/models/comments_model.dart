// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

commentModel commentModelFromJson(String str) =>
    commentModel.fromJson(json.decode(str));

String commentModelToJson(commentModel data) => json.encode(data.toJson());

// ignore: camel_case_types
class commentModel {
  commentModel({
    required this.id,
    required this.Owner,
    required this.Group,
    required this.Comment,
    required this.Date,
  });

  ObjectId id;
  String Owner;
  ObjectId Group;
  String Comment;
  DateTime Date;

  factory commentModel.fromJson(Map<String, dynamic> json) => commentModel(
        id: json["_id"],
        Owner: json["owner"],
        Group: json["group"],
        Comment: json["comment"],
        Date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "owner": Owner,
        "group": Group,
        "comment": Comment,
        "date": Date,
      };
}
