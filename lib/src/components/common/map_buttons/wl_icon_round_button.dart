import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WLIconRoundButton extends StatelessWidget {

  const WLIconRoundButton({this.elevation = 1, this.bgColor = Colors.white, required this.onPressed, required this.iconUrl, required this.size});

  final String iconUrl;
  final double size;
  final double elevation;
  final Color bgColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: FloatingActionButton(
              elevation: elevation,
              child: SvgPicture.asset(
                  iconUrl,
                  semanticsLabel: 'Map Type BTN'
              ),
              backgroundColor: bgColor,
              onPressed: onPressed),
        ));
  }
}

