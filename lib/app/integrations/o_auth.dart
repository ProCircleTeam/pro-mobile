import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

class OAuth {
  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    try {
      final auth = await googleSignIn.authenticate();
      print("Token ==================> ${auth.authentication.idToken}");
      print("display name ==================> ${auth.displayName}");
      print("photo url ==================> ${auth.photoUrl}");
      print("email ==================> ${auth.email}");
    } catch (e) {
      print("Error signin in with google ===============> $e");
    }
  }
}
