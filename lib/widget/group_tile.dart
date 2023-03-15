import 'package:flutter/material.dart';

import '../Chat Page/chat_page.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;

  const GroupTile(
      {super.key,
      required this.userName,
      required this.groupId,
      required this.groupName});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      groupId: widget.groupId,
                      groupName: widget.groupName,
                      userName: widget.userName,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: ListTile(
          subtitle: Text(
            "Join the conversation ${widget.userName}",
            style: TextStyle(fontSize: 13),
          ),
          title: Text(
            widget.groupName,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0, 1).toLowerCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
