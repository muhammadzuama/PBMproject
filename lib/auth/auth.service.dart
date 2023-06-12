import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  var instance = FirebaseAuth.instance;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await instance.signInWithCredential(credential);

    // Once signed in, return the UserCredential
  }

  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true; // Sign-out successful
    } catch (e) {
      print('Error during sign out: $e');
      return false; // Sign-out failed
    }
  }
}

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<UserCredential> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      // Handle any errors that occur during the sign-up process
      print('Sign up error: $e');
      throw e;
    }
  }
}
