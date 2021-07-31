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

class CustomIconButton1 extends StatelessWidget {
  const CustomIconButton1(
      {Key? key, void Function()? this.onTap, required Widget this.icon})
      : super(key: key);
  final onTap;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        color: Colors.transparent,
        shape: CircleBorder(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          // customBorder: CircleBorder(),
          splashColor: Theme.of(context).splashColor,
          highlightColor: Theme.of(context).splashColor,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: icon,
          ),
        ),
      ),
    );
  }
}

class CustomMiniButton1 extends StatelessWidget {
  const CustomMiniButton1({
    Key? key,
    required Function() this.onPressed,
    required String this.label,
    Color? this.color,
  }) : super(key: key);

  final onPressed;
  final label;
  final color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 23,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
            fontSize: 10,
          ),
        ),
        style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.resolveWith((states) => Size(56, 23)),
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.white),
          foregroundColor:
              MaterialStateProperty.resolveWith((states) => Color(0xFF605252)),
          shape: MaterialStateProperty.resolveWith((states) =>
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          elevation: MaterialStateProperty.resolveWith((states) => 0),
          side: MaterialStateProperty.resolveWith((states) => BorderSide(
                width: 1,
                color: Theme.of(context).backgroundColor,
              )),
        ),
      ),
    );
  }
}
