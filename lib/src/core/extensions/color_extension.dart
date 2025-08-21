import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color customOpacity(double opacity) {
    return withAlpha((255 * opacity).round());
  }
}
