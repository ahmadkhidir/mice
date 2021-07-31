import 'package:flutter/material.dart';
import 'package:mice/ui/component/custom_button.dart';

class CustomContentContainer1 extends StatelessWidget {
  const CustomContentContainer1({
    Key? key,
    required ImageProvider<Object> this.image,
    required String this.title,
    required String this.description,
    required void Function() this.onPressed,
  }) : super(key: key);
  final image;
  final title;
  final description;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 10),
      margin: EdgeInsets.only(right: 30),
      // Height take the Cotainer height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x44000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment(-1, -0.28),
            heightFactor: 0,
            child: Container(
              width: 65,
              height: 65,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFFEECF2),
              ),
              child: Image(
                image: image,
                width: 46,
                height: 46,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: SizedBox(
                  width: 130,
                  child: Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              CustomMiniButton1(
                onPressed: onPressed,
                label: 'JOIN',
              )
            ],
          ),
        ],
      ),
    );
  }
}
