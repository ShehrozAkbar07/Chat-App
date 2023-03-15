// import 'dart:ui';

// import 'package:chat_app/login.dart';
// import 'package:chat_app/service/auth_service.dart';
// import 'package:chat_app/service/database_service.dart';
// import 'package:chat_app/signup.dart';
// import 'package:chat_app/widget/group_tile.dart';
// import 'package:chat_app/widget/widgets.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// import 'helper/helper.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     gettingUserData();
//   }
//   //String manupulation

//   String getId(String res) {
//     return res.substring(0, res.indexOf("_"));
//   }

//   String getName(String res) {
//     return res.substring(res.indexOf("_") + 1);
//   }

//   gettingUserData() async {
//     await HelperFunction.getUserEmailFromSF().then((value) {
//       setState(() {
//         email = value!;
//       });
//     });
//     await HelperFunction.getUserNameFromSF().then((value) {
//       setState(() {
//         userName = value!;
//       });
//     });
//     await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
//         .getUserGroups()
//         .then((snapshot) {
//       setState(() {
//         groups = snapshot;
//       });
//     });
//   }

//   Stream? groups;
//   String groupName = "";

//   String userName = "";
//   String email = "";
//   bool? _isLoading = false;
//   AuthService auth = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           centerTitle: true,
//           title: const Text(
//             'Profile',
//             style: TextStyle(fontSize: 24, color: Colors.white),
//           ),
//           leading: const Icon(
//             Icons.search,
//             color: Colors.white,
//           )),
//       body: grouplist(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           popupDialoug(context);
//         },
//         child: Icon(
//           Icons.add,
//           size: 35,
//           color: Colors.white,
//         ),
//         backgroundColor: const Color(0xffec6f59),
//       ),
//     );
//   }

//   popupDialoug(BuildContext context) {
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (context, setState) {
//             return AlertDialog(
//               title: const Text(
//                 'Create a group',
//                 textAlign: TextAlign.left,
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _isLoading == true
//                       ? Center(
//                           child: CircularProgressIndicator(
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         )
//                       : TextField(
//                           onChanged: (val) {
//                             setState(() {
//                               groupName = val;
//                             });
//                           },
//                           style: TextStyle(color: Colors.black),
//                           decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Theme.of(context).primaryColor),
//                                   borderRadius: BorderRadius.circular(20)),
//                               focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Theme.of(context).primaryColor),
//                                   borderRadius: BorderRadius.circular(20)),
//                               errorBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.red),
//                                   borderRadius: BorderRadius.circular(20))),
//                         )
//                 ],
//               ),
//               actions: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context).primaryColor),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text("Cancel"),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context).primaryColor),
//                   onPressed: () async {
//                     if (groupName != "") {
//                       setState(() {
//                         _isLoading = true;
//                       });
//                     }
//                     ;
//                     DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
//                         .creatGroup(FirebaseAuth.instance.currentUser!.uid,
//                             groupName, userName)
//                         .whenComplete(() {
//                       setState(() {
//                         _isLoading = false;
//                       });
//                     });
//                     Navigator.pop(context);
//                     showSnackBar(
//                         context, Colors.green, 'Group is created Sucessfully');
//                   },
//                   child: Text("Create"),
//                 )
//               ],
//             );
//           });
//         });
//   }

//   grouplist() {
//     return StreamBuilder(
//         stream: groups,
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             if (snapshot.data['groups'] != null) {
//               if (snapshot.data['groups'].length != 0) {
//                 return ListView.builder(
//                     itemCount: snapshot.data['groups'].length,
//                     itemBuilder: (context, index) {
//                       int reveseGroup =
//                           snapshot.data['groups'].length - index - 1;
//                       return GroupTile(
//                           userName: getName(snapshot.data['fullName']),
//                           groupId: getId(snapshot.data['groups'][reveseGroup]),
//                           groupName:
//                               getName(snapshot.data['groups'][reveseGroup]));
//                     });
//               } else {
//                 return noGroupwidget();
//               }
//             } else {
//               return noGroupwidget();
//             }
//           } else {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: Theme.of(context).primaryColor,
//               ),
//             );
//           }
//           ;
//         });
//   }

//   noGroupwidget() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           InkWell(
//             onTap: () {
//               popupDialoug(context);
//             },
//             child: const Icon(
//               Icons.add_circle,
//               color: Colors.grey,
//               size: 75,
//             ),
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           const Text(
//             "You haven't joined any groups, tap on the add icon to create a group or also search from top search",
//             textAlign: TextAlign.center,
//             style:
//                 TextStyle(fontSize: 15, color: Color.fromARGB(255, 44, 41, 41)),
//           ),
//         ],
//       ),
//     );
//   }
// }
