import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/touchable_opacity/touchable_opacity.dart';

class SupportScreenRemoveAttachedFile extends ConsumerWidget {
  final void Function() onPress;

  const SupportScreenRemoveAttachedFile({
    Key? key,
    required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: 50,
        child: Container(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                  child: Center(
                    child: Icon(
                      Icons.done,
                      size: 24,
                      color: Colors.black38,
                    ),
                  ),
                ),
                Text(
                  t(context).supportScreen_fileAttached,
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                TouchableOpacity(
                    child: Text(
                      t(context).supportScreen_removeAttachedFile,
                      style: const TextStyle(
                          color: Colors.red
                      ),
                    ),
                    onTap: onPress
                )
              ],
            )
        )
    );
  }
}