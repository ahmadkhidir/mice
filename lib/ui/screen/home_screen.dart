import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mice/prototype/firebase/notifier.dart';
import 'package:mice/prototype/navigator/right_slide_navigator.dart';
import 'package:mice/ui/component/custom_button_1.dart';
import 'package:mice/ui/component/custom_mesenger.dart';
import 'package:mice/ui/screen/splash_screen.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isUser = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<FireBaseAuthNotifier>()
        .authentication
        .authStateChanges()
        .listen((event) {
      if (event == null) {
        snackBarMessage(context, message: "You're logged out");
        Navigator.pushAndRemoveUntil(context,
            RightSlideNavigator(widget: SplashScreen()), (route) => false);
      }
    });
    return Scaffold(
      body: StreamBuilder(
        stream:
            context.read<FireBaseAuthNotifier>().authentication.userChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          return Column(
            children: [
              Text('${snapshot.data?.phoneNumber}'),
              CustomButton1(
                  onPressed: () => context
                      .read<FireBaseAuthNotifier>()
                      .authentication
                      .signOut(),
                  label: 'Sign Out'),
            ],
          );
        },
      ),
    );
  }
}
