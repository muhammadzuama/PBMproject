import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:server_coba/utils/global.color.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ImagePicker picker = ImagePicker();
  void takePhoto(image) async {
    final ImagePicker picker = ImagePicker();
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
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
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
                                  color: Colors.black.withOpacity(0.1))
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    'https://fajar.co.id/wp-content/uploads/2023/03/Screenshot_2023_0330_120521.jpg')))),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            // Aksi yang ingin Anda lakukan saat ikon kamera diklik
                            print('Ikon kamera diklik!');
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: GlobalColors.button,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 30),
              buildTextField("Username", "alamin", false),
              buildTextField("Email", "alaminmzuama@gamil.com", false),
              buildTextField("No HP", "081999999", false),
              buildTextField("Password", "081999999", false),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        backgroundColor: GlobalColors.button),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const DashboardView()),
                      // );
                    },
                    child: const Text(
                      "Save",
                    )),
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
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
                bottom: 8), // Atur jarak antara label dan retangle di sini
            child: Text(
              labelText,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 1), // Atur jarak padding horizontal di sini
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: TextField(
              obscureText: isPasswordTextField ? true : false,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: isPasswordTextField
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.remove_red_eye, color: Colors.grey),
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