import 'package:flutter/material.dart';
import 'package:server_coba/utils/global.color.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),
      // ),
      backgroundColor: GlobalColors.background,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  height: 137,
                  decoration: BoxDecoration(
                    color: GlobalColors
                        .button, // Ubah warna rectangle sesuai kebutuhan Anda
                    // borderRadius: BorderRadius.circular(10),
                  )),

              // const SizedBox(
              //   height: 11,
              // ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Username ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextField(
                      // controller: usernameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan Username ",
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
                    'Email',
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
                      keyboardType: TextInputType.emailAddress,
                      // controller: passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Masukkan Email",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 168, 168, 168)
                              .withOpacity(0.6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 17),
                      ), // Menampilkan inputan sebagai password
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'NO HP',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      // controller: konfirmpasswordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "NOMOR HP",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 168, 168, 168)
                              .withOpacity(0.6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 17),
                      ), // Menampilkan inputan sebagai password
                    ),
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      // controller: konfirmpasswordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
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
                        onPressed: () {},
                        child: const Text(
                          "SAVE",
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
