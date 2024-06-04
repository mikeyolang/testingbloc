import 'package:flutter/material.dart';

import 'package:testingbloc/strings.dart' show enterYourEmailHere;

class EmailTextfield extends StatelessWidget {
  final TextEditingController emailController;
  const EmailTextfield({
    super.key,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: const InputDecoration(
          hintText: enterYourEmailHere,
        ),
      ),
    );
  }
}
