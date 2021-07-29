import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mice/prototype/navigator/bouncy_navigator.dart';
import 'package:mice/ui/component/custom_button_1.dart';
import 'package:mice/ui/component/custom_mesenger.dart';
import 'package:mice/ui/component/custom_text_field_1.dart';
import 'package:mice/ui/screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:mice/prototype/firebase/notifier.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<String?> signIn(BuildContext context,
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

Future<String?> signUp(BuildContext context,
    {required String email,
    required String password,
    required String name,
    required String phoneNumber}) async {
  FireBaseAuthNotifier auth =
      Provider.of<FireBaseAuthNotifier>(context, listen: false);

  try {
    String fullPhoneNumber =
        '+234' + phoneNumber.replaceFirst(RegExp(r'0'), '');
    UserCredential user = await auth.authentication
        .createUserWithEmailAndPassword(email: email, password: password);
    await user.user!.updateDisplayName(name);
    await auth.authentication.verifyPhoneNumber(
      phoneNumber: fullPhoneNumber,
      verificationCompleted: (phoneAuthCredential) async =>
          await user.user!.updatePhoneNumber(phoneAuthCredential),
      verificationFailed: (error) {
        if (error.code == 'invald-phone-number') {
          snackBarMessage(context,
              message: 'The provided phone number is not valid');
        }
      },
      codeSent: (verificationId, forceResendingToken) async {
        TextEditingController sentCodeController = TextEditingController();
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Enter SMS Code sent to $fullPhoneNumber'),
            content: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: CustomTextField2(
                        controller: sentCodeController, labelText: 'Code here'),
                  ),
                  CustomButton1(
                      onPressed: () async {
                        final credential = PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: sentCodeController.text);
                        user.user!.updatePhoneNumber(credential);
                        auth.notifyListeners();
                        Navigator.pushAndRemoveUntil(
                            context,
                            BouncyNavigator(widget: HomeScreen()),
                            (route) => false);
                      },
                      label: 'Done'),
                ],
              ),
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) => null,
    );
    return 'verify-otp';
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
