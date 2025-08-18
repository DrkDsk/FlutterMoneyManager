import 'package:flutter/material.dart';

class AddSummaryButton extends StatelessWidget {
  const AddSummaryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.blueAccent.shade100,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onPrimary.withOpacity(0.80),
                offset: const Offset(0, 3),
                blurRadius: 1,
              )
            ]
        ),
        child: Icon(Icons.add, size: 36, color: theme.colorScheme.primary),
      ),
    );
  }
}