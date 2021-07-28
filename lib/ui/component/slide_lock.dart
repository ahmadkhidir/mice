import 'package:flutter/material.dart';

class SlideLock extends StatefulWidget {
  const SlideLock({Key? key, Function(dynamic)? this.onAccept})
      : super(key: key);
  final onAccept;
  @override
  _SlideLockState createState() => _SlideLockState();
}

class _SlideLockState extends State<SlideLock> {
  var onDrag = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Color(0xFF852D48),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        ),
      ),
      height: 38,
      width: 270,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DragTarget<int>(
            builder: (context, candidateData, rejectedData) {
              if (candidateData.isEmpty) {
                if (onDrag) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      // color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    width: 38,
                    height: 38,
                    child: Icon(Icons.lock_outline, color: Colors.white),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Slide To Continue Anonymously',
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontSize: 12,
                      ),
                    ),
                  );
                }
              } else {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // color: Colors.green,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(Icons.lock_open_outlined, color: Colors.white),
                  width: 38,
                  height: 38,
                );
              }
            },
            onWillAccept: (data) => data == 200,
            onAccept: (data) => widget.onAccept(data),
          ),
          Draggable<int>(
            data: 200,
            axis: Axis.horizontal,
            onDragStarted: () {
              setState(() {
                onDrag = true;
              });
            },
            onDragEnd: (details) {
              setState(() {
                onDrag = false;
              });
            },
            childWhenDragging: Container(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              height: 38,
              width: 38,
            ),
            feedback: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              height: 38,
              width: 38,
            ),
          ),
        ],
      ),
    );
  }
}
