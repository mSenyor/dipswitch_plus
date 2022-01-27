import 'dart:ui';

import 'package:dipswitch_plus/constants.dart';
import 'package:flutter/material.dart';


class AddressDigit extends StatelessWidget {
  
  final int value;
  VoidCallback? onPressDown;
  VoidCallback? onPressUp;

  AddressDigit({Key? key, required this.value, this.onPressDown, this.onPressUp }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: onPressUp,
              icon: Icon(
                Icons.arrow_upward,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                value.toString(),
                style: kAddressDigitTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: onPressDown,
              icon: Icon(
                Icons.arrow_downward,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
