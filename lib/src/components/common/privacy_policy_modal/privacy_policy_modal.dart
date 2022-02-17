import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/privacy_policy_modal/data/privacy_policy_en.dart';
import 'package:true_flutter/src/components/common/privacy_policy_modal/data/privacy_policy_ru.dart';

class PrivacyPolicyModal extends StatelessWidget {
  const PrivacyPolicyModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
    final bool localeIsRussian = currentLocale.languageCode == "ru";

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff01bfa5),
            // centerTitle: true,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
            title: Text(
              t(context).privacyPolicyModal_headerTitle,
              style: const TextStyle(
                  color: Colors.white
              ),
            ),
            elevation: 0.0
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Html(
                  data: localeIsRussian
                      ? PrivacyPolicyRU.data
                      : PrivacyPolicyEN.data,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class PrivacyPolicyModal extends StatelessWidget {
//   const PrivacyPolicyModal({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         width: MediaQuery
//             .of(context)
//             .size
//             .width,
//         height: MediaQuery
//             .of(context)
//             .size
//             .height,
//         padding: EdgeInsets.all(20),
//         color: Colors.white,
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text('Hai This Is Full Screen Dialog',
//                 style: TextStyle(color: Colors.red, fontSize: 20.0),),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("DISMISS",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }