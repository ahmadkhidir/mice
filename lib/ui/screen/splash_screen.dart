import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mice/prototype/firebase/authentication.dart';
import 'package:mice/prototype/firebase/notifier.dart';
import 'package:mice/prototype/navigator/bouncy_navigator.dart';
import 'package:mice/ui/component/custom_mesenger.dart';
import 'package:mice/ui/screen/home_screen.dart';

import 'package:provider/provider.dart';

import 'package:mice/ui/component/custom_button_1.dart';
import 'package:mice/ui/component/slide_lock.dart';

import 'package:mice/ui/screen/login_screen.dart';
import 'package:mice/ui/screen/signup_screen.dart';

import 'package:mice/prototype/navigator/right_slide_navigator.dart';
import 'package:mice/prototype/navigator/left_slide_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
    Size screen = MediaQuery.of(context).size;
    hideNavBar();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: screen.width,
        height: screen.height,
        child: ListView(
          padding: EdgeInsets.only(top: 130, left: 50, right: 50, bottom: 50),
          children: [
            Image.asset(
              'assets/image/logo.gif',
              height: 120,
              // width: 100,
            ),
            Container(
              margin: EdgeInsets.only(top: 300),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomButton1(
                      onPressed: () => Navigator.push(
                          context, LeftSlideNavigator(widget: LoginScreen())),
                      label: 'LOG IN',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomButton1(
                      onPressed: () => Navigator.push(
                          context, RightSlideNavigator(widget: SignupScreen())),
                      label: 'SIGN UP',
                    ),
                  ),
                  SlideLock(onAccept: (value) async {
                    String? auth = await anonymousAuth(context);
                    if (auth == 'authenticated') {
                      Navigator.push(
                          context, BouncyNavigator(widget: HomeScreen()));
                    } else if (auth == 'operation-not-allowed') {
                      snackBarMessage(context,
                          message: "You're not allowed to sign in Anonymously");
                    } else if (auth == 'network-request-failed') {
                      snackBarMessage(context,
                          message:
                              'Internet Issue: There might be no internet connection');
                    } else {
                      snackBarMessage(context,
                          message: 'Unexpected Error Occured!');
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future hideNavBar() async {
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFFD23766)),
  );
}
