import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/specific/phone_number_authentication/phone_number_input/country_code/country_code.dart';

class PhoneNumberAuthenticationPhoneNumberInput extends ConsumerWidget {
  final String phoneNumber;
  final CountryWithPhoneCode countryCode;
  final int correctNumberOfDigitsInPhoneNumber;
  final void Function(String text) onPhoneNumberChanged;
  final void Function() onCountryCodePress;

  const PhoneNumberAuthenticationPhoneNumberInput({
    Key? key,
    required this.phoneNumber,
    required this.countryCode,
    required this.correctNumberOfDigitsInPhoneNumber,
    required this.onPhoneNumberChanged,
    required this.onCountryCodePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: 60,
        child: Center(
          child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                // color: Colors.white38,
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  CountryCode(
                    countryCode: countryCode,
                    onPress: onCountryCodePress,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        // color: Colors.amber,
                        child: TextFormField(
                          initialValue: phoneNumber,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(
                                correctNumberOfDigitsInPhoneNumber),
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: t(context).phoneNumberAuthenticationScreen_phoneNumberPlaceholder,
                          ),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54
                          ),
                          onChanged: onPhoneNumberChanged,
                        )
                    ),
                  )
                ],
              )
          ),
        )
    );
  }
}