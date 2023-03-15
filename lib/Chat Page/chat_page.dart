import 'package:chat_app/Groups/group_info.dart';
import 'package:chat_app/service/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const ChatPage(
      {super.key,
      required this.userName,
      required this.groupId,
      required this.groupName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  String admin = "";

  @override
  void initState() {
    GetChatandAdmin();
    // TODO: implement initState
    super.initState();
  }

  GetChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val){
      setState(() {
        chats = val;
      });


    });
     DatabaseService().getGroupAdmin(widget.groupId).then((val){
      setState(() {
        admin = val;
      });


    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(widget.groupName),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupInfo(
                              groupId: widget.groupId,
                              groupName: widget.groupName,
                              adminName: admin,
                            )));
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Center(
            child: Text(widget.groupName),
          ),
        ],
      ),
    );
  }
}
