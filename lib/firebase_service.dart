import 'package:projet_flutter2/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  
  Future<void> authAnonyme() => _auth.signInAnonymously().then((credential) => {
    // print(credential.user!.uid)
  });
  
  Future<bool> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (result.user != null) return true;
      return false;
    } catch (e) {
      return false;
    }
  }


  Future<bool> send(String email, String password) async {
    try {
      final result = await _auth.sendSignInLinkToEmail(email: email, actionCodeSettings: ActionCodeSettings(url: ''));
      // if (result.user != null) return true;
      // print(result!);
      return false;
    } catch (e) {
      return false;
    }
  }


  Future<bool> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // final resulte = await _auth.;
      if (result.user != null) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  Stream<User?> get userChange => _auth.authStateChanges();
  
  Future<void> logOut() => _auth.signOut().then((value) => null);

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      print(user);
      await user.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future reloadUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.reload();

  }
}