import 'package:mongo_dart/mongo_dart.dart';
import 'dart:convert';

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
}
