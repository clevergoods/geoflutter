import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:true_flutter/src/presentation/authentication/views/phone_authentication/country_code_selector_modal.dart';
import 'package:true_flutter/src/components/common/privacy_policy_modal/privacy_policy_modal.dart';
import 'package:true_flutter/src/components/common/user_agreement_modal/user_agreement_modal.dart';
import 'package:true_flutter/src/components/specific/phone_number_authentication/app_logo/phone_number_authentication_app_logo.dart';
import 'package:true_flutter/src/components/specific/phone_number_authentication/footer/phone_number_authentication_footer.dart';
import 'package:true_flutter/src/components/specific/phone_number_authentication/password_input/phone_number_authentication_password_input.dart';
import 'package:true_flutter/src/components/specific/phone_number_authentication/phone_number_authentication_options/phone_number_authentication_options.dart';
import 'package:true_flutter/src/components/specific/phone_number_authentication/phone_number_input/phone_number_authentication_phone_number_input.dart';
import 'package:true_flutter/src/components/specific/phone_number_authentication/registration_hint/phone_number_authentication_registration_hint.dart';
import 'package:true_flutter/src/data/specific/phone_number_authentication/phone_number_authentication_mode/phone_number_authentication_mode.dart';

import '../../../../utils/common/system_log/flogger.dart';
import '../../../phone_number_authentication/controllers/phone_number_authentication_controller.dart';
import '../../../phone_number_authentication/models/phone_number_authentication_model.dart';
import '../../controllers/phone_authentication_screen_controller.dart';
import '../../models/phone_authentication_screen_model_state.dart';
import 'loader.dart';

class PhoneAuthenticationScreenView extends ConsumerStatefulWidget {
  const PhoneAuthenticationScreenView({Key? key}) : super(key: key);

  @override
  ConsumerState<PhoneAuthenticationScreenView> createState() =>
      PhoneAuthenticationScreenState();
}

class PhoneAuthenticationScreenState
    extends ConsumerState<PhoneAuthenticationScreenView> {

  late PhoneAuthenticationScreenController controller;
  late String title;

  static const logTag = 'AuthenticationScreenView';
  Flogger get logger => GetIt.instance.get<Flogger>();
  final phoneAuthenticationProvider = StateNotifierProvider<PhoneAuthenticationScreenController, PhoneAuthenticationScreenModelState>(
          (ref) => PhoneAuthenticationScreenController());

  @override
  initState() {
    super.initState();
    controller = ref.read(phoneAuthenticationProvider.notifier);
    controller.loadCountries();
  }

  @override
  Widget build(BuildContext context) {
    final modelState = ref.watch(phoneAuthenticationProvider);

    final bool showUserAgreementsAndPrivacyPolicy = modelState.currentMode ==
        PhoneNumberAuthenticationMode.Registration;

    return Stack(
      children: [
        Positioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'lib/src/assets/images/login_background.png'),
                  fit: BoxFit.fill,
                ),
              ),
              height: 450,
              width: double.infinity,
            )
        ),
        Column(
          children: [
            const PhoneNumberAuthenticationAppLogo(),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            PhoneNumberAuthenticationPhoneNumberInput(
                phoneNumber: modelState.enteredPhoneNumber,
                correctNumberOfDigitsInPhoneNumber: modelState
                    .correctNumberOfDigitsInPhoneNumber,
                onPhoneNumberChanged: controller.phoneNumberChangeHandler,
                onCountryCodePress: (){
                  _showCountryCodeSelectorModal(context, modelState.countries);
                }, countryCode: CountryWithPhoneCode.us(),
            ),
            modelState.showPasswordField
                ? PhoneNumberAuthenticationPasswordInput(
              password: modelState.enteredPassword,
              passwordVisible: modelState.passwordVisible,
              onPasswordChanged: controller.passwordChangeHandler,
              onVisibilityPress: controller.passwordVisibilityPressHandler,
            )
                : const PhoneNumberAuthenticationRegistrationHint(),
            Container(
              height: 50,
            ),
            PhoneNumberAuthenticationOptions(
              currentMode: modelState.currentMode,
              onRegisterPress: controller.registerPressHandler,
              onSignInPress: controller.signInPressHandler,
            ),
            PhoneNumberAuthenticationFooter(
              showUserAgreementsAndPrivacyPolicy: showUserAgreementsAndPrivacyPolicy,
              onUserAgreementPress: () {
                _showUserAgreementModal(context);
              },
              onPrivacyPolicyPress: () {
                _showPrivacyPolicyModal(context);
              },
              onRequestPasswordPress: controller.requestPasswordPressHandler,
              onRegisterNowPress: controller.registerNowPressHandler,
            )
          ],
        )
      ],
    );
  }

  void _showCountryCodeSelectorModal(BuildContext context, List<CountryWithPhoneCode>? countries) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          if(countries != null) {
            return CountryCodeSelectorModal(countries);
          } else {
            return const Loader();
          }
        }
    );
  }

  void _showPrivacyPolicyModal(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return const PrivacyPolicyModal();
        }
    );
  }

  void _showUserAgreementModal(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return const UserAgreementModal();
        }
    );
  }
}

// ===
// =====
// _displayDialog(BuildContext context) {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     // transitionDuration: Duration(milliseconds: 2000),
//     // transitionBuilder: (context, animation, secondaryAnimation, child) {
//     //   return FadeTransition(
//     //     opacity: animation,
//     //     child: ScaleTransition(
//     //       scale: animation,
//     //       child: child,
//     //     ),
//     //   );
//     // },
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return SafeArea(
//         child: Container(
//           width: MediaQuery
//               .of(context)
//               .size
//               .width,
//           height: MediaQuery
//               .of(context)
//               .size
//               .height,
//           padding: EdgeInsets.all(20),
//           color: Colors.white,
//           child: Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text('Hai This Is Full Screen Dialog',
//                   style: TextStyle(color: Colors.red, fontSize: 20.0),),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text("DISMISS",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
// =====
// ===