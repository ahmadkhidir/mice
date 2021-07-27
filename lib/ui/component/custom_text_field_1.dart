import 'package:flutter/material.dart';

class CustomTextField1 extends StatelessWidget {
  const CustomTextField1({
    Key? key,
    required TextEditingController this.controller,
    required String this.labelText,
    bool this.obscureText = false,
  }) : super(key: key);

  final labelText;
  final controller;
  final obscureText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white, fontSize: 16),
        // cursorHeight: 25,
        obscureText: obscureText,
      ),
    );
  }
}

class CustomTextFormField1 extends StatelessWidget {
  const CustomTextFormField1({
    Key? key,
    required TextEditingController this.controller,
    required String this.labelText,
    String? Function(String?)? this.validator,
    bool this.obscureText = false,
  }) : super(key: key);

  final labelText;
  final controller;
  final obscureText;
  final validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: TextFormField(
        controller: controller,
        validator: (value) => validator(value),
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.yellow,
              width: 2,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.yellow,
              width: 2,
            ),
          ),
          errorStyle: TextStyle(
            color: Colors.yellow,
          ),
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white, fontSize: 16),
        // cursorHeight: 25,
        obscureText: obscureText,
      ),
    );
  }
}
