import 'package:flutter/material.dart';

import 'package:testingbloc/strings.dart' show enterYourPasswordHere;

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordTextField({
    super.key,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: TextFormField(
        autocorrect: false,
        obscureText: true,
        obscuringCharacter: "🔘",
        keyboardType: TextInputType.emailAddress,
        controller: passwordController,
        decoration: const InputDecoration(
          hintText: enterYourPasswordHere,
        ),
      ),
    );
  }
}
