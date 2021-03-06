import 'package:flutter/material.dart';

import 'package:mice/prototype/firebase/authentication.dart';
import 'package:mice/prototype/navigator/bouncy_navigator.dart';
import 'package:mice/prototype/utils/validator.dart';

import 'package:mice/ui/component/custom_text_field.dart';
import 'package:mice/ui/component/custom_button.dart';
import 'package:mice/ui/component/custom_mesenger.dart';
import 'package:mice/ui/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // String info = '';

  @override
  Widget build(BuildContext context) {
    emailController.addListener(() {});
    passwordController.addListener(() {});

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              ListView(
                padding:
                    EdgeInsets.only(left: 50, right: 50, top: 100, bottom: 50),
                children: [
                  Image.asset(
                    'assets/image/ic_portrait_48px.png',
                    alignment: Alignment.topCenter,
                    height: 128,
                    width: 128,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 70),
                    child: Center(
                        child: Text(
                      'LOG IN TO YOUR ACCOUNT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                      ),
                    )),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextFormField1(
                                controller: emailController,
                                validator: (value) =>
                                    Validator.validateEmail(email: value),
                                labelText: 'E-MAIL ADDRESS',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40.0),
                                child: CustomTextFormField1(
                                  controller: passwordController,
                                  validator: (value) =>
                                      Validator.validatePassword(
                                          password: value),
                                  labelText: 'PASSWORD',
                                  obscureText: true,
                                ),
                              ),
                              CustomButton1(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      String? auth = await signIn(context,
                                          email: emailController.text,
                                          password: passwordController.text);
                                      if (auth == 'authenticated') {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            BouncyNavigator(
                                                widget: HomeScreen()),
                                            (route) => false);
                                      } else if (auth == 'wrong-password') {
                                        snackBarMessage(context,
                                            message: 'Wrong Password!');
                                      } else if (auth == 'user-not-found') {
                                        snackBarMessage(context,
                                            message:
                                                'User not found, please kindly register');
                                      } else if (auth ==
                                          'network-request-failed') {
                                        snackBarMessage(context,
                                            message:
                                                'Internet Issue: There might be no internet connection');
                                      } else if (auth == null) {
                                        snackBarMessage(context,
                                            message:
                                                'Undefined Error Occured!');
                                      } else {
                                        snackBarMessage(context,
                                            message:
                                                'Unexpected Error Occured!');
                                      }
                                    }
                                  },
                                  label: 'LOG IN'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CustomButton1(
                              onPressed: () async {
                                String? auth = await googleSignIn(context);
                                if (auth == 'authenticated') {
                                  snackBarMessage(context,
                                      message:
                                          'Successfully Logged In with Google');
                                } else {
                                  snackBarMessage(context,
                                      message:
                                          'An error occured with Google Authentication');
                                }
                              },
                              label: 'AUTHORIZE WITH GOOGLE'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                  alignment: Alignment(.8, -.95),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/image/close.png',
                      height: 50,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
