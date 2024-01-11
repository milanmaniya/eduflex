import 'package:eduflex/screen/welcome_screen/welcome_screen.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationReposotiry extends GetxController {
  static AuthenticationReposotiry get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {}

// login
  Future<UserCredential> loginWithEmailIdAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return user;
    } catch (e) {
      throw 'Sometimes went wrong. Please try again';
    }
  }

// register
  Future<UserCredential> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return user;
    } catch (e) {
      throw 'Sometimes went wrong. Please try again';
    }
  }

  // sign in with google
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await userAccount!.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return FirebaseAuth.instance.signInWithCredential(credentials);
    } catch (e) {
      throw TLoader.warningSnackBar(
          title: 'Email Send Verification', message: e.toString());
    }
  }

  // mail verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      TLoader.warningSnackBar(
          title: 'Email Send Verification', message: e.toString());
    }
  }

  //logout
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      Get.offAll(() => const WelcomeScreen());
    } catch (e) {
      TLoader.warningSnackBar(title: '', message: e.toString());
    }
  }
}
