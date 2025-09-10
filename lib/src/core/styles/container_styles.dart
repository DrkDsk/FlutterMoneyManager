import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';

class ContainerStyles {
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
}
