import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/touchable_opacity/touchable_opacity.dart';

class SupportScreenSendButton extends StatelessWidget {
  final void Function() onPress;

  const SupportScreenSendButton({
    Key? key,
    required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
        child: Container(
          height: 38,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xffea4235),
            border: Border.all(
              color: const Color(0xffea4235),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: Icon(
                    Icons.support_agent,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                t(context).supportScreen_sendButton,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white
                ),
              )
            ],
          ),
        ),
        onTap: onPress
    );
  }
}