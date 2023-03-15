import 'package:chat_app/Groups/groups.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/database_service.dart';
import 'package:chat_app/signup.dart';
import 'package:chat_app/widget/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Common/custom_button.dart';
import 'Common/textfield.dart';
import 'helper/helper.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

AuthService _authServicee = AuthService();

final formKey = GlobalKey<FormState>();

String email = "";
String password = "";
bool isLoading = false;

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? Center(
            child: const CircularProgressIndicator(color: Color(0xffec6f59)))
        : Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    const Text(
                      "Groupie",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    const Text(
                      "Create your account now to chat & explore",
                      style: TextStyle(fontSize: 22, color: Colors.grey),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFee7b64), width: 2),
                          ),
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          )),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },

                      // check tha validation
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Please enter a valid email";
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFee7b64), width: 2),
                          ),
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          )),
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Password must be at least 6 characters";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        login();
                      },
                      child: CustomButton(
                        text: 'Login',
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 44, 41, 41)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: const Text(
                              "Register now",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 53, 50, 50),
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      await _authServicee.signIn(email, password).then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);
          await HelperFunction.saveUSerLoggedInStatus(true);
          await HelperFunction.saveUserEmailSF(email);
          await HelperFunction.saveUserNameSF(snapshot.docs[0]['fullName']);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Groups()));

          setState(() {
            isLoading = false;
          });
        } else {
          showSnackBar(context, Colors.red, value);

          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }
}
