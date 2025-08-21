import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';

final kWidgetRoundedDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.turquoise.customOpacity(0.15)));

final kTabBarDecoration = BoxDecoration(
    color: AppColors.secondary.customOpacity(0.60),
    borderRadius: BorderRadius.circular(12));
