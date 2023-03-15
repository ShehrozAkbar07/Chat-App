import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Profile extends StatefulWidget {
  final String email;
  final String userName;

  const Profile({super.key, required this.email, required this.userName});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          leading: const Icon(
            Icons.search,
            color: Colors.white,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Container(
              height: size.height * 0.24,
              width: size.width * 0.9,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 44, 41, 41)),
                ),
                Text(
                  widget.userName,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 53, 50, 50),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 44, 41, 41)),
                ),
                Text(
                  widget.email,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 53, 50, 50),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
