import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';

class SupportScreenEmailInput extends StatelessWidget {
  final String userEmail;
  final void Function(String text) onTextChanged;

  const SupportScreenEmailInput({
    Key? key,
    required this.userEmail,
    required this.onTextChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Center(
          child: TextFormField(
            initialValue: userEmail,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              hintText: t(context).supportScreen_emailPlaceholder,
            ),
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black54
            ),
            onChanged: onTextChanged,
          ),
        )
      ),
    );
  }
}