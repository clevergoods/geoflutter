import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/touchable_opacity/touchable_opacity.dart';

class PhoneNumberAuthenticationPasswordInput extends StatelessWidget {
  final String password;
  final bool passwordVisible;
  final void Function(String text) onPasswordChanged;
  final void Function() onVisibilityPress;

  const PhoneNumberAuthenticationPasswordInput({
    Key? key,
    required this.password,
    required this.passwordVisible,
    required this.onPasswordChanged,
    required this.onVisibilityPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      // color: Colors.green,
      child: Center(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 50,
                  // color: Colors.amber,
                  child: Icon(
                    Icons.lock,
                    color: Colors.black38,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      // color: Colors.amber,
                      child: TextFormField(
                        initialValue: password,
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: t(context).phoneNumberAuthenticationScreen_passwordPlaceholder,
                        ),
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54
                        ),
                        onChanged: (text) {
                          onPasswordChanged(text);
                        },
                      )
                  ),
                ),
                TouchableOpacity(
                  child: SizedBox(
                      width: 50,
                      // color: Colors.green,
                      child: Icon(
                          passwordVisible ? Icons.visibility : Icons
                              .visibility_off,
                          color: Colors.black38
                      )
                  ),
                  onTap: onVisibilityPress,
                ),
              ],
            ),
          )
      ),
    );
  }
}