import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'prototype/firebase/notifier.dart';

import 'package:mice/ui/screen/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseAuth.instance.useAuthEmulator('192.168.43.120', 9099);
  runApp(Mice());
}

class Mice extends StatelessWidget {
  const Mice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmailAndPasswordNotifier>(
          create: (context) => EmailAndPasswordNotifier(),
        ),
        ChangeNotifierProvider<GoogleSignInNotifier>(
          create: (context) => GoogleSignInNotifier(),
        ),
      ],
      child: MaterialApp(
        color: Color(0xFFD23766),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData(
          backgroundColor: Color(0xFFD23766),
        ),
      ),
    );
  }
}
