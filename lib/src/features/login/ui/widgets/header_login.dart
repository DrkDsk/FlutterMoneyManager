import 'package:flutter/material.dart';

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text("Hi, Welcome Back! 👋",
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: Colors.black, fontSize: 25)),
        const SizedBox(height: 10,),
        Text(
          "We happy to see you. Sign in to your account",
          style: theme.textTheme.bodySmall,
        )
      ],
    );
  }
}