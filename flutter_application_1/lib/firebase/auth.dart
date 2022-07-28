import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_application_1/firebase/exception.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future SingUp(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
        throw AuthException("No such user");
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password');
      } else if (e.code == 'invalid-email') {
        throw AuthException('Bad format for email');
      }
    }
  }

  Future SignIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e == 'weal-password') {
        print('The password provided is too weak');
        throw AuthException("Password is too weak");
      } else if (e.code == 'email-already-use') {
        print("The account already exists for this email");
        throw AuthException("The account already exists for this email");
      }
    } catch (e) {
      print(e);
    }
  }
}
