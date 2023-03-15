import 'package:chat_app/Groups/groups.dart';
import 'package:chat_app/helper/helper.dart';
import 'package:chat_app/home.dart';
import 'package:chat_app/login.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'Common/custom_button.dart';
import 'Common/textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

// TextEditingController emailController = TextEditingController();
// TextEditingController passwordController = TextEditingController();
// TextEditingController usenrnameController = TextEditingController();

AuthService authService = AuthService();
final formKey = GlobalKey<FormState>();

String fullName = "";

String email = "";
String password = "";
bool isLoading = false;

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    print(emailController);
    // print(usenrnameController);
    print(passwordController);

    print(email);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: formKey,
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
                          labelText: "Full Name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          )),
                      onChanged: (val) {
                        setState(() {
                          fullName = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isNotEmpty) {
                          return null;
                        } else {
                          return "Name cannot be empty";
                        }
                      },
                    ),
                    // CustomTextField(
                    //   obsecure_Text: false,
                    //   // controller: usenrnameController,
                    //   icon: const Icon(
                    //     Icons.person,
                    //     color: Color(0xffec6f59),
                    //   ),
                    //   text: 'Full Name',
                    //   validator_value: 'Please Enter Name',
                    //   onChange_value: fullname,
                    // ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
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
                    // CustomTextField(
                    //   obsecure_Text: false,
                    //   // controller: emailController,
                    //   icon: const Icon(
                    //     Icons.mail,
                    //     color: Color(0xffec6f59),
                    //   ),
                    //   text: 'Email',
                    //   validator_value: 'Please Enter Email',
                    //   onChange_value: email,
                    // ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
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
                    // CustomTextField(
                    //   obsecure_Text: true,
                    //   // controller: passwordController,
                    //   icon: const Icon(
                    //     Icons.lock,
                    //     color: Color(0xffec6f59),
                    //   ),
                    //   text: 'Password',
                    //   validator_value: 'Please Enter Password',
                    //   onChange_value: password,
                    // ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        register();
                      },
                      child: CustomButton(
                        text: 'Register',
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
                                      builder: (context) => Login()));
                            },
                            child: const Text(
                              "Login now",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 53, 50, 50),
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          await HelperFunction.saveUSerLoggedInStatus(true);
          await HelperFunction.saveUserEmailSF(email);
          await HelperFunction.saveUserNameSF(fullName);
          // await HelperFunction.saveUserEmailSF(fullName);
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
