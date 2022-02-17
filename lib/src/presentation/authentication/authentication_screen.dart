import 'package:flutter/material.dart';
import 'package:true_flutter/src/presentation/authentication/views/authentication_screen_view.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthenticationScreenView(),
    );
  }
}