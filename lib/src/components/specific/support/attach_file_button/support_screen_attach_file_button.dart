import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/touchable_opacity/touchable_opacity.dart';

class SupportScreenAttachFileButton extends StatelessWidget {
  final void Function() onPress;

  const SupportScreenAttachFileButton({
    Key? key,
    required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: SizedBox(
        height: 50,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(
                width: 38,
                child: Center(
                  child: Icon(
                    Icons.attachment,
                    size: 24,
                    color: Colors.black38,
                  ),
                ),
              ),
              Text(
                t(context).supportScreen_attachFileButton,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
        ),
      ),
      onTap: onPress,
    );
  }
}