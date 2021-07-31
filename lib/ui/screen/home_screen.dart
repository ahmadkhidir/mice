import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mice/prototype/firebase/authentication.dart';
import 'package:mice/prototype/firebase/notifier.dart';
import 'package:mice/prototype/navigator/left_slide_navigator.dart';
import 'package:mice/prototype/navigator/right_slide_navigator.dart';
import 'package:mice/ui/component/custom_button.dart';
import 'package:mice/ui/component/custom_container.dart';
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
  late Animation sizeTween;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  User? user;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 500));
    // _scrollController = ScrollController();

    sizeTween = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.slowMiddle));

    _controller.addListener(() {});
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
        .userChanges()
        .listen((event) => setState(() => user = event));

    systemSettings();

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
        titleSpacing: 0,
        toolbarHeight: 40.0 + (sizeTween.value * 30.0),
        title: Column(
          children: [
            Container(
              height: sizeTween.value * 30.0,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).splashColor,
              child: Text(
                'Make money today with simple Tasks and ADs',
                style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).backgroundColor,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomIconButton1(
                    onTap: () => _scaffoldKey.currentState!.openDrawer(),
                    icon: Image.asset(
                      'assets/image/avatar.png',
                    ),
                  ),
                  SizedBox(
                      width: 50, child: Image.asset('assets/image/logo.png')),
                  CustomIconButton1(
                      onTap: () => print('search'),
                      icon: Image.asset('assets/image/search.png')),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: SafeArea(
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: appBarAnimationHandler,
          child: ListView(
            children: [
              // Text('${user?.phoneNumber}'),
              // CustomButton1(
              //     onPressed: () async {
              //       await signOut(context);
              //     },
              //     label: 'Sign Out'),
              // Placeholder(
              //   fallbackHeight: 5000,
              // ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                margin: EdgeInsets.only(top: 60),
                child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: (notification) {
                    return true;
                  },
                  child: ListView(
                    // shrinkWrap: true,
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 30),
                    children: [
                      CustomContentContainer1(
                        description:
                            'Earn money now through watching of video advertisement',
                        title: 'VIDEO ADS',
                        image: AssetImage('assets/image/google.png'),
                        onPressed: () => null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        child: Icon(Icons.add),
        foregroundColor: Theme.of(context).backgroundColor,
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(),
      ),
    );
  }

  bool appBarAnimationHandler(ScrollUpdateNotification notification) {
    print(notification.metrics.pixels);
    if (notification.scrollDelta!.isNegative) {
      setState(() {
        _controller.reverse();
      });
    } else {
      setState(() {
        _controller.forward();
      });
    }
    if (notification.metrics.atEdge) {
      _controller.reverse();
    }
    return false;
  }
}

Future systemSettings() async {
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFFD23766),
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}
