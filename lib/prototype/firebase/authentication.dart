import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:mice/prototype/firebase/notifier.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<String?> signInWithEmailAndPassword(BuildContext context,
    {required String email, required String password}) async {
  FireBaseAuthNotifier auth =
      Provider.of<FireBaseAuthNotifier>(context, listen: false);
  try {
    UserCredential user = await auth.authentication
        .signInWithEmailAndPassword(email: email, password: password);
    auth.notifyListeners();
    print('Authenticated ${user.user!.email}');
    return 'authenticated';
  } on FirebaseAuthException catch (e) {
    print(e.code);
    print(e.message);
    return e.code;
  }
}

Future<String?> anonymousAuth(BuildContext context) async {
  FireBaseAuthNotifier auth =
      Provider.of<FireBaseAuthNotifier>(context, listen: false);

  try {
    UserCredential user = await auth.authentication.signInAnonymously();
    auth.notifyListeners();
    print('Authenticated ${user.user!.uid}');
    return 'authenticated';
  } on FirebaseAuthException catch (e) {
    print(e.code);
    print(e.message);
    return e.code;
  }
}

Future<String?> googleSignIn(BuildContext context) async {
  GoogleSignInNotifier googleAuth =
      Provider.of<GoogleSignInNotifier>(context, listen: false);
  FireBaseAuthNotifier auth =
      Provider.of<FireBaseAuthNotifier>(context, listen: false);

  final googleSignIn = googleAuth.googleSignIn;
  try {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication!.accessToken,
        idToken: googleSignInAuthentication.idToken);
    await auth.authentication.signInWithCredential(credential);
    googleAuth.notifyListeners();
    return 'authenticated';
  } on FirebaseAuthException catch (error) {
    print(error.message);
    return 'error';
    // return null;
  } catch (error) {
    print('error');
    return 'error';
  }
}
