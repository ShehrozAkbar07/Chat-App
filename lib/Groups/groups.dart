import 'package:chat_app/Profile/profile.dart';
import 'package:chat_app/helper/helper.dart';
import 'package:chat_app/login.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/database_service.dart';
import '../widget/group_tile.dart';
import '../widget/widgets.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getUserData();
  // }

  // getUserData() async {
  //   await HelperFunction.getUserEmailFromSF().then((value) {
  //     setState(() {
  //       email = value!;
  //     });
  //   });
  //   await HelperFunction.getUserNameFromSF().then((value) {
  //     setState(() {
  //       userName = value!;
  //     });
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }
  //String manupulation

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunction.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunction.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  Stream? groups;
  String groupName = "";

  String userName = "";
  String email = "";
  bool? _isLoading = false;
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 35, top: 10),
              child: Text(
                userName,
                style: const TextStyle(color: Colors.black, fontSize: 28),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: () {},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              leading: const Icon(Icons.group),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              title: const Text(
                'Groups',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                              email: email,
                              userName: userName,
                            )));
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              leading: const Icon(Icons.person),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Logout"),
                        content: Text("Are you sure want to Logout"),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () {
                                auth.signOut().whenComplete(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                });
                              },
                              icon: const Icon(
                                Icons.done,
                                color: Colors.green,
                              ))
                        ],
                      );
                    });
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              leading: const Icon(Icons.logout),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          'Group',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
        ],
      ),
      body: grouplist(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popupDialoug(context);
        },
        child: Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xffec6f59),
      ),
    );
  }

  popupDialoug(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Create a group',
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : TextField(
                          onChanged: (val) {
                            setState(() {
                              groupName = val;
                            });
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(20))),
                        )
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () async {
                    if (groupName != "") {
                      setState(() {
                        _isLoading = true;
                      });
                    }
                    ;
                    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                        .creatGroup(FirebaseAuth.instance.currentUser!.uid,
                            groupName, userName)
                        .whenComplete(() {
                      setState(() {
                        _isLoading = false;
                      });
                    });
                    Navigator.pop(context);
                    showSnackBar(
                        context, Colors.green, 'Group is created Sucessfully');
                  },
                  child: Text("Create"),
                )
              ],
            );
          });
        });
  }

  grouplist() {
    return StreamBuilder(
        stream: groups,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != null) {
              if (snapshot.data['groups'].length != 0) {
                return ListView.builder(
                    itemCount: snapshot.data['groups'].length,
                    itemBuilder: (context, index) {
                      int reveseGroup =
                          snapshot.data['groups'].length - index - 1;
                      return GroupTile(
                          userName: getName(snapshot.data['fullName']),
                          groupId: getId(snapshot.data['groups'][reveseGroup]),
                          groupName:
                              getName(snapshot.data['groups'][reveseGroup]));
                    });
              } else {
                return noGroupwidget();
              }
            } else {
              return noGroupwidget();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          ;
        });
  }

  noGroupwidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              popupDialoug(context);
            },
            child: const Icon(
              Icons.add_circle,
              color: Colors.grey,
              size: 75,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "You haven't joined any groups, tap on the add icon to create a group or also search from top search",
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 15, color: Color.fromARGB(255, 44, 41, 41)),
          ),
        ],
      ),
    );
  }
}
