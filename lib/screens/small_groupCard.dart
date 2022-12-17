import 'package:flutter/material.dart';
import 'package:tusgrupos/models/group_model.dart';

class SmallGroupCard extends StatelessWidget {
  const SmallGroupCard({Key? key, required this.group}) : super(key: key);
  final groupModel group;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(group.Name),
    );
  }
}
