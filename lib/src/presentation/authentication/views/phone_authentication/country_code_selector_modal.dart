import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';

import '../../controllers/phone_authentication_screen_controller.dart';
import '../../models/phone_authentication_screen_model_state.dart';

class CountryCodeSelectorModal extends ConsumerWidget {
  CountryCodeSelectorModal(this.countries, {Key? key}) : super(key: key);

  final List<CountryWithPhoneCode> countries;

  final phoneAuthenticationProvider = StateNotifierProvider<PhoneAuthenticationScreenController, PhoneAuthenticationScreenModelState>(
          (ref) => PhoneAuthenticationScreenController());


  @override
  Widget build(BuildContext context, WidgetRef ref) {


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
                }),
            title: Text(
              t(context).countryCodeSelectorModal_headerTitle,
              style: const TextStyle(color: Colors.white),
              // style: TextStyle(
              //     color: Colors.black87, fontFamily: 'Overpass', fontSize: 20),
            ),
            elevation: 0.0),
        body: Consumer(
          builder: (context, ref, _) {
            return ListView.separated(
              itemCount: countries.length,
              separatorBuilder: (_, __) => Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Divider(
                  color: Colors.grey[400],
                  height: 0.5,
                ),
              ),
              itemBuilder: (BuildContext context, int index) {
                final country = countries[index];
                return _countryListTile(context, ref, country);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _countryListTile(
    BuildContext context,
    WidgetRef ref,
    CountryWithPhoneCode country,
  ) {
    return ListTile(
      dense: true,
      title: Text(
        '${country.countryName}',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
      trailing: Text(
        '+${country.phoneCode}',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16.0, color: Colors.grey),
      ),
      onTap: () {
        PhoneAuthenticationScreenController controller =
            ref.read(phoneAuthenticationProvider.notifier);
        controller.setCountry(country);
        Navigator.pop(context);
      },
    );
  }
}
