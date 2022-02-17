import 'package:flutter/material.dart';

class WLTextRoundButton extends StatelessWidget {
  final String text;

  final double size;
  final double elevation;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onPressed;
  const WLTextRoundButton(
      {this.elevation = 1,
      required this.onPressed,
      required this.text,
      required this.size,
      required this.bgColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: FloatingActionButton(
              heroTag: text,
              elevation: elevation,
              child: Text(text,
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                  )),
              backgroundColor: bgColor,
              onPressed: onPressed),
        ));
  }
}
