import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:server_coba/main.dart';
import 'package:server_coba/utils/global.color.dart';
import 'package:server_coba/view/login.view.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  late FirebaseAuth _firebaseAuth;
  late GoogleSignIn _googleSignIn;
  User? _currentUser;

  @override
  void initState() {
    _firebaseAuth = FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn();
    _currentUser = _firebaseAuth.currentUser;
    super.initState();
  }

  Future<void> getImage(ImageSource camera) async {
    final image = await ImagePicker().pickImage(source: camera);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      _image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.button,
        title: const Text("Edit Profile"),
        leading: IconButton(
          icon: const Icon(
            Icons.logout_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            _googleSignIn.signOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginView()),
            );
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                        shape: BoxShape.circle,
                        image: _image != null
                            ? DecorationImage(
                                image: FileImage(_image!), fit: BoxFit.fill)
                            : _currentUser != null &&
                                    _currentUser!.photoURL != null
                                ? DecorationImage(
                                    image:
                                        NetworkImage(_currentUser!.photoURL!),
                                    fit: BoxFit.fill)
                                : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: GlobalColors.button,
                          ),
                          child: IconButton(
                            onPressed: () => getImage(ImageSource.camera),
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              buildTextField(
                  "Username", _currentUser?.displayName ?? "", false),
              buildTextField("Email", _currentUser?.email ?? "", false),
              buildTextField("No HP", _currentUser?.phoneNumber ?? "",
                  false), // Tambahkan fungsi ini sesuai kebutuhan
              buildTextField("Password", "",
                  true), // Tambahkan fungsi ini sesuai kebutuhan
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    backgroundColor: GlobalColors.button,
                  ),
                  onPressed: () {
                    // Tambahkan logika disini untuk menyimpan profil
                  },
                  child: const Text(
                    "Save",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              labelText,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: TextField(
              obscureText: isPasswordTextField,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: isPasswordTextField
                    ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye,
                            color: Colors.grey),
                      )
                    : null,
                contentPadding: const EdgeInsets.only(bottom: 5),
                hintText: placeholder,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
