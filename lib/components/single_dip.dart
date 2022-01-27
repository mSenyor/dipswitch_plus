import 'package:flutter/material.dart';
import 'dart:math' as math;

class SingleDip extends StatelessWidget {

  final VoidCallback? onPress;
  final int switchNumber;
  final int switchValue;
  final bool on;
  late int switchRotationAngle;

  void getAngle(bool state){
    if(state){
      switchRotationAngle = 270;
    }else{
      switchRotationAngle = 90;
    }
  }

  SingleDip({Key? key, required this.on, required this.switchValue, required this.switchNumber, this.onPress}) : super(key: key) {
    getAngle(on);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          margin: EdgeInsets.all(1),
          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                switchValue==512?'extra':switchValue.toString(),
              // switchValue.toString(),
              ),
              Expanded(
                child: Transform.rotate(
                  angle: switchRotationAngle * math.pi / 180,
                  child: Icon(
                    Icons.toggle_on_outlined,
                  ),
                ),
              ),
              Text(
                switchNumber.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
