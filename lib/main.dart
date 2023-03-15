import 'package:chat_app/Groups/groups.dart';
import 'package:chat_app/Shared/constant.dart';
import 'package:chat_app/helper/helper.dart';
import 'package:chat_app/login.dart';
import 'package:chat_app/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'Profile/profile.dart';
import 'firebase_options.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    //initial for and or ios

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSignedIn = false;

  void initState() {
    super.initState();
    getUserLoggerInStatus();
  }

  getUserLoggerInStatus() async {
    await HelperFunction.getUserLoggerInStatus().then((value) {
      if (value != null) {
        setState(() {
          isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Constants().primaryColor),
      debugShowCheckedModeBanner: false,
      home:
       isSignedIn ? const Groups() : const SignUp(),
      
    );
  }
}
