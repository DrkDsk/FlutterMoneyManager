import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';

class HeaderCalendar extends StatelessWidget {
  const HeaderCalendar(
      {super.key,
      required this.onLeftTap,
      required this.onRightTap,
      required this.titleCalendar});

  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;
  final String titleCalendar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleCalendar,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.secondary),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: onLeftTap,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.turquoise, shape: BoxShape.circle),
                child: const Icon(Icons.keyboard_arrow_left_outlined,
                    color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onRightTap,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.turquoise, shape: BoxShape.circle),
                child: const Icon(Icons.keyboard_arrow_right_outlined,
                    color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
}
