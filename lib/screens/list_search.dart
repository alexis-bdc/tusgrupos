import 'package:flutter/material.dart';

class ListSearch extends StatelessWidget {
  ListSearch(String name, String owner, {super.key});
  String? name;
  String? owner;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(name!));
  }
}
