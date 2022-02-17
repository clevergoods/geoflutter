import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/touchable_opacity/touchable_opacity.dart';

class SupportScreenAskInTelegramButton extends StatelessWidget {
  final void Function() onPress;

  const SupportScreenAskInTelegramButton({
    Key? key,
    required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            height: 25,
            width: 25,
            child: const Image(
                image: AssetImage('lib/src/assets/images/telegram_icon.png')
            ),
          ),
          Text(
            t(context).supportScreen_askInTelegramButton,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
      onTap: onPress,
    );
  }
}