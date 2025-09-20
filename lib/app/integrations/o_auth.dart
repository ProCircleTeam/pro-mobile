// class OAuth {
//   Future<void> signInWithGoogle() async {
//     final GoogleSignIn _googleSignIn = GoogleSignIn(
//       scopes: ["email", "profile"],
//     );

//     try {
//       final googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return;

//       final auth = await googleUser.authentication;

//       print("Access Token: ${auth.accessToken}");
//     print("ID Token: ${auth.idToken}");

//     // Send ID token to backend for verification
//     // Example:
//     // final response = await http.post(
//     //   Uri.parse("https://your-backend.com/api/auth/google"),
//     //   body: {"id_token": auth.idToken},
//     // );

//     } catch (e) {
//       print("Error signin in with Google =============> $e");
//     }
//   }
// }
