import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/custom_divider.dart';

class LoginAlternativeContainer extends StatelessWidget {
  const LoginAlternativeContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: CustomDivider(),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "Or Sign In with",
          style: TextStyle(
              color: Colors.grey.shade400, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          width: 10,
        ),
        const Expanded(
          child: CustomDivider(),
        ),
      ],
    );
  }
}
