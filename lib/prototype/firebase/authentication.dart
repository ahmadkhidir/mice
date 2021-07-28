import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:mice/prototype/firebase/notifier.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<String?> emailAndPassword(BuildContext context,
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

Future<GoogleSignInAccount?> googleSignIn(BuildContext context) async {
  GoogleSignInNotifier auth =
      Provider.of<GoogleSignInNotifier>(context, listen: false);
  final googleSignIn = auth.googleSignIn;
  try {
    GoogleSignInAccount? user = await googleSignIn.signIn();
    return user;
  } catch (error) {
    print(error);
    return null;
  }
}
