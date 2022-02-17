import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/components/common/touchable_opacity/touchable_opacity.dart';

class CountryCode extends ConsumerWidget {
  final Function() onPress;
  final CountryWithPhoneCode countryCode;

  const CountryCode({
    Key? key,
    required this.onPress,
    required this.countryCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TouchableOpacity(
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 14.0, right: 8.0),
              child: Center(
                child: Text(
                  "${countryCode.countryCode} +${countryCode.phoneCode}",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              )
          ),
          const SizedBox(
            // color: Colors.green,
            width: 25,
            child: Center(
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
      onTap: onPress,
    );
  }
}