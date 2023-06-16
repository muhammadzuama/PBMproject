import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:server_coba/admin/mitra.adminview.dart';
import 'package:server_coba/auth/auth.service.dart';
// import 'package:server_coba/mitra/mitra.view.dart';
import 'package:server_coba/utils/global.color.dart';
import 'package:server_coba/view/daftar.view.dart';
import 'package:server_coba/view/home.view.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late GoogleAuth _googleAuth;

  @override
  void initState() {
    _googleAuth = GoogleAuth();
    super.initState();
  }

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
              const Text(
                "Selamat Datang",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 11,
              ),
              const Text(
                "Selamat datang kembali! Yuk login biar bisa akses fitur kita.",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Username',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan Username",
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 110),
                  GestureDetector(
                    onTap: () {
                      // aksi ketika teks Forget Password ? diklik
                      print("Forgot Password");
                    },
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    backgroundColor: GlobalColors.button,
                  ),
                  onPressed: () {
                    if (emailController.text == 'admin' &&
                        passwordController.text == 'admin123') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ViewMitraAdmin()),
                      );
                    } else {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        if (value.user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Homepage(userCredential: value),
                            ),
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
                    }
                  },
                  child: const Text(
                    "LOGIN",
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    backgroundColor: GlobalColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Sesuaikan radius sesuai kebutuhan Anda
                      side: const BorderSide(
                          color: Colors.brown,
                          width:
                              2), // Ganti dengan warna dan lebar stroke yang diinginkan
                    ),
                  ),
                  onPressed: () {
                    _googleAuth.signInWithGoogle().then((value) {
                      if (value.user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Homepage(userCredential: value),
                          ),
                        );
                      }
                    });
                  },
                  icon: Image.network(
                    'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png', // Ganti dengan URL gambar ikon Google Anda
                    width: 20, // Sesuaikan ukuran ikon sesuai kebutuhan Anda
                    height: 20,
                  ),
                  label: const Text(
                    "Login Dengan Google",
                    style: TextStyle(color: Colors.brown),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
