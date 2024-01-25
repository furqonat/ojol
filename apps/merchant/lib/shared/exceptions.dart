import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthError {
  static void signInError(FirebaseAuthException e) {
    if (e.code == 'auth/user-not-found') {
      Fluttertoast.showToast(msg: 'No user found for that email.');
    } else if (e.code == 'auth/wrong-password') {
      Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
    } else if (e.code == 'auth/too-many-requests') {
      Fluttertoast.showToast(msg: 'Too many requests. Try again later.');
    } else if (e.code == 'auth/invalid-email') {
      Fluttertoast.showToast(
          msg: 'Invalid email. Please provide a valid email.');
    } else {
      Fluttertoast.showToast(msg: e.code);
    }
  }
}
