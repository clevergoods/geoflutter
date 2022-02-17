import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';

class SupportScreenMessageInput extends StatelessWidget {
  final String userMessage;
  final void Function(String text) onTextChanged;

  const SupportScreenMessageInput({
    Key? key,
    required this.userMessage,
    required this.onTextChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: const BorderRadius.all(Radius.circular(2)),
          ),
          child: TextFormField(
            initialValue: userMessage,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(10.0),
              hintText: t(context).supportScreen_messagePlaceholder,
            ),
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black54
            ),
            onChanged: onTextChanged,
          ),
        )
    );
  }
}