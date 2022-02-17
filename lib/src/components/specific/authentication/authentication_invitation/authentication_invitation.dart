import 'package:flutter/material.dart';
import 'package:true_flutter/src/assets/localization/localization.dart';

class AuthenticationInvitation extends StatelessWidget {
  const AuthenticationInvitation({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          t(context).authenticationScreen_hello,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 36
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 150,
                  child: Image(image: AssetImage(
                      'lib/src/assets/images/login_wokka.png')),
                )
              ],
            ),
          ),
          SizedBox(
              height: 50,
              width: double.infinity,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}
