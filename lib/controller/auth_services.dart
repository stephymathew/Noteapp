import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_note_app/controller/firestore_services.dart';
import 'package:my_note_app/views/constants/constants.dart';

enum AuthResults {
  accountCreatedSuccess,
  weakPassword,
  emailAlreadyInUse,
  somethingWentWrong,
  logInSuccess,
  wrongpassword,
}

class AuthServices {
  static Future<AuthResults> signupUser(
      String name, String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FireStoreServices.saveUser(
          name, email, password, userCredential.user!.uid);
      uid = userCredential.user!.uid;

      print("signup ${userCredential.credential}");
      return AuthResults.accountCreatedSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return AuthResults.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return AuthResults.emailAlreadyInUse;
      }
    } catch (e) {
      return AuthResults.somethingWentWrong;
    }
    return AuthResults.somethingWentWrong;
  }

  static Future<AuthResults> signIn(
    String email,
    String password,
  ) async {
    try {
      final credi = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      uid = credi.user!.uid;
      return AuthResults.logInSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return AuthResults.wrongpassword;
      } else {
        return AuthResults.somethingWentWrong;
      }
    }
  }

  static getuid() {
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  static signout() {
    FirebaseAuth.instance.signOut();
  }
}
