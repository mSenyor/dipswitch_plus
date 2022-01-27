import 'package:flutter/material.dart';
import 'address_digit.dart';


class AddressRow extends StatelessWidget {

  final int hundredsDigit;
  final int tensDigit;
  final int onesDigit;
  VoidCallback? onPressPlusHundreds;
  VoidCallback? onPressPlusTens;
  VoidCallback? onPressPlusOnes;
  VoidCallback? onPressMinusHundreds;
  VoidCallback? onPressMinusTens;
  VoidCallback? onPressMinusOnes;

  AddressRow({Key? key,
    required this.hundredsDigit,
    required this.onesDigit,
    required this.tensDigit,
    this.onPressMinusHundreds,
    this.onPressMinusOnes,
    this.onPressMinusTens,
    this.onPressPlusHundreds,
    this.onPressPlusOnes,
    this.onPressPlusTens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AddressDigit(
          value: hundredsDigit,
          onPressUp: onPressPlusHundreds,
          onPressDown: onPressMinusHundreds,
        ),
        AddressDigit(
          value: tensDigit,
          onPressUp: onPressPlusTens,
          onPressDown: onPressMinusTens,
        ),
        AddressDigit(
          value: onesDigit,
          onPressUp: onPressPlusOnes,
          onPressDown: onPressMinusOnes,
        ),
      ],
    );
  }
}
