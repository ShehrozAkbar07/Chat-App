import 'package:chat_app/helper/helper.dart';
import 'package:chat_app/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        DatabaseService(
          uid: user.uid,
        ).savingUserData(fullName, email);

        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//signout

  Future signOut() async {
    try {
      await HelperFunction.saveUSerLoggedInStatus(false);
      await HelperFunction.saveUserEmailSF("");
      await HelperFunction.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

// sign in

  Future signIn(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
