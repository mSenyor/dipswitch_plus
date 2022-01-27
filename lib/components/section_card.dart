import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final VoidCallback? onPress;
  final Widget? cardChild;
  final Color? backgroundColor;

  const SectionCard({Key? key, this.onPress, this.cardChild, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
      ),
    );
  }
}
