import 'package:flutter/material.dart';
import 'package:true_flutter/src/components/common/touchable_opacity/touchable_opacity.dart';

class SimpleRoundedButton extends StatelessWidget {
  final String title;
  final Color color;
  final void Function() onPress;

  const SimpleRoundedButton({
    Key? key,
    required this.title,
    required this.color,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Container(
        width: double.infinity,
        height: 38,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: color,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 2.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white
              )
          ),
        ),
      ),
      onTap: onPress,
    );
  }
}