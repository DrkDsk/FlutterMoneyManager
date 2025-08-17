import 'package:flutter/material.dart';

class RegisterLink extends StatelessWidget {
  const RegisterLink({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "Create here",
          style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}