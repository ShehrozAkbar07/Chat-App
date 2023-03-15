import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class GroupInfo extends StatefulWidget {
  final String groupId;
  final String groupName;

  final String adminName;
  const GroupInfo(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.adminName});

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:Text(widget.adminName)),
    );
  }
}
