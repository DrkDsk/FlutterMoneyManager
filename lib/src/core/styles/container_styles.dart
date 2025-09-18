import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';

class ContainerStyles {
  static final BoxDecoration defaultBorder = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.shade100,
            offset: const Offset(0, 3),
            blurRadius: 0.5)
      ]);

  static final kWidgetRoundedDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.turquoise.customOpacity(0.15)));

  static final kTabBarContainerDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.turquoise.customOpacity(0.8)));

  static final kTabBarDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: AppColors.turquoise,
  );

  static final statContainerBoxContainer = BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.customOpacity(0.5),
            offset: const Offset(0, 3),
            blurRadius: 0.1)
      ],
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.turquoise.customOpacity(0.8)));
}
