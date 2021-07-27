import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  const CustomButton1({
    Key? key,
    required Function() this.onPressed,
    required String this.label,
  }) : super(key: key);

  final onPressed;
  final label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(label),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.resolveWith((states) => Size(270, 50)),
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => Colors.white),
        foregroundColor:
            MaterialStateProperty.resolveWith((states) => Color(0xFF605252)),
        shape: MaterialStateProperty.resolveWith((states) =>
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
        elevation: MaterialStateProperty.resolveWith((states) => 2),
        shadowColor:
            MaterialStateProperty.resolveWith((states) => Color(0x44000000)),
      ),
    );
  }
}
