
// import 'package:flutter/material.dart';
// import 'package:server_coba/utils/global.color.dart';

// class LoginView extends StatelessWidget {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: GlobalColors.background,
//       body: Center(
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 32),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Selamat Datang",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 11,
//               ),
//               const Text(
//                 "Selamat datang kembali Yuk login biar bisa akses fitur kita",
//                 style: TextStyle(fontSize: 12),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Username ',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white),
//                     child: TextField(
//                       // controller: usernameController,
//                       decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Masukkan Username ",
//                           hintStyle: TextStyle(
//                               fontSize: 15,
//                               color: const Color.fromARGB(255, 168, 168, 168)
//                                   .withOpacity(0.6)),
//                           contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 17)),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   const Text(
//                     'Password',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                     ),
//                     child: TextField(
//                       // controller: passwordController,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Masukkan Password",
//                         hintStyle: TextStyle(
//                           fontSize: 15,
//                           color: const Color.fromARGB(255, 168, 168, 168)
//                               .withOpacity(0.6),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 17),
//                       ),
//                       obscureText: true, // Menampilkan inputan sebagai password
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   const SizedBox(width: 110),
//                   GestureDetector(
//                     onTap: () {
//                       // aksi ketika teks Forget Password ? diklik
//                       print("Forgot Password");
//                     },
//                     child: const Text(
//                       "Forgot Password ?",
//                       style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 15),
//                         backgroundColor: GlobalColors.button),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const DashboardView()),
//                       );
//                     },
//                     child: const Text(
//                       "LOGIN",
//                     )),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Belum punya akun ?"),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const Register()),
//                       );
//                     },
//                     child: const Text("Sign Up",
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }