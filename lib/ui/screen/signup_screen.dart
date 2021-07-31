import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:mice/prototype/firebase/authentication.dart';
import 'package:mice/prototype/navigator/bouncy_navigator.dart';
import 'package:mice/prototype/utils/validator.dart';
import 'package:mice/prototype/firebase/notifier.dart';

import 'package:mice/ui/component/custom_text_field.dart';
import 'package:mice/ui/component/custom_button.dart';
import 'package:mice/ui/component/custom_mesenger.dart';
import 'package:mice/ui/screen/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // String info = '';

  @override
  Widget build(BuildContext context) {
    emailController.addListener(() {});
    nameController.addListener(() {});
    phoneNumberController.addListener(() {});
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
                      'REGISTER FOR AN ACCOUNT',
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
                                controller: nameController,
                                validator: (value) =>
                                    Validator.validateName(name: value),
                                labelText: 'FULL NAME',
                              ),
                              CustomTextFormField1(
                                controller: emailController,
                                validator: (value) =>
                                    Validator.validateEmail(email: value),
                                labelText: 'E-MAIL ADDRESS',
                              ),
                              CustomTextFormField1(
                                controller: phoneNumberController,
                                validator: (value) =>
                                    Validator.validatePhoneNumber(
                                        phoneNumber: value),
                                labelText: 'PHONE NUMBER (NG)',
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
                                      String? auth = await signUp(
                                        context,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phoneNumber: phoneNumberController.text,
                                      );
                                      if (auth == 'verify-otp') {
                                        snackBarMessage(context,
                                            message:
                                                'Waiting for verification');
                                      } else if (auth == 'weak-password') {
                                        snackBarMessage(context,
                                            message:
                                                'Your password is too weak!, use a strong password');
                                      } else if (auth ==
                                          'email-already-in-use') {
                                        snackBarMessage(context,
                                            message:
                                                'The email address is already in use by another account');
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
                                  label: 'SIGN UP'),
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
