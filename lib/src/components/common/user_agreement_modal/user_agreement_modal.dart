import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';
import 'package:true_flutter/src/components/common/user_agreement_modal/data/user_agreement_en.dart';
import 'package:true_flutter/src/components/common/user_agreement_modal/data/user_agreement_ru.dart';

class UserAgreementModal extends StatelessWidget {
  const UserAgreementModal({Key? key}) : super(key: key);

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
                t(context).userAgreementModal_headerTitle,
                style: const TextStyle(
                    color: Colors.white
                ),
                // style: TextStyle(
                //     color: Colors.black87, fontFamily: 'Overpass', fontSize: 20),
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
                          ? UserAgreementRU.data
                          : UserAgreementEN.data
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}