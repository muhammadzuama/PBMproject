import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:server_coba/utils/global.color.dart';

import 'home.view.dart';

final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController konfirmpasswordController = TextEditingController();

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.background,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello! Register to get started',
                style: TextStyle(
                    color: GlobalColors.button,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 11,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Email ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan Email ",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: const Color.fromARGB(255, 168, 168, 168)
                                  .withOpacity(0.6)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 17)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Password',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Masukkan Password",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 168, 168, 168)
                              .withOpacity(0.6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 17),
                      ),
                      obscureText: true, // Menampilkan inputan sebagai password
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Konfirmasi Password',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: konfirmpasswordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Konfirmasi Password",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 168, 168, 168)
                              .withOpacity(0.6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 17),
                      ),
                      obscureText: true, // Menampilkan inputan sebagai password
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            backgroundColor: GlobalColors.button),
                        onPressed: () {
                          String inputUsername = usernameController
                              .text; // Get the entered username/email
                          String inputPassword = passwordController.text;
                          String password2 = konfirmpasswordController.text;

                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: inputUsername, password: inputPassword)
                              .then((value) {
                            if (value.user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => Homepage()),
                              );
                            }
                          }).catchError((error) {
                            // Handle sign-up errors
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Sign-up Error"),
                                content: Text(
                                    "An error occurred during sign-up: $error"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          });

                          if (inputPassword != password2) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Invalid Password"),
                                content: const Text(
                                    "Password and Confirmation Password do not match."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }

                          // Mengambil nilai inputan password
                        },
                        child: const Text(
                          "REGISTER",
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
