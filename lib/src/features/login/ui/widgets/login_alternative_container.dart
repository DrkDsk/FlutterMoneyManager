import 'package:flutter/material.dart';

class LoginAlternativeContainer extends StatelessWidget {
  const LoginAlternativeContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey.shade400,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "Or Sign In with",
          style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}