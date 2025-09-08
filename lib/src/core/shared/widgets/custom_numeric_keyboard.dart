import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';

class CustomNumericKeyboard extends StatelessWidget {
  final Function(String) onNumberTap;
  final VoidCallback onOkSubmit;
  final VoidCallback onBackspace;

  const CustomNumericKeyboard(
      {super.key,
      required this.onNumberTap,
      required this.onBackspace,
      required this.onOkSubmit});

  Widget _buildButton(String text,
      {VoidCallback? onTap, TextStyle? style, BoxDecoration? decoration}) {
    final buttonStyle = style ??
        TextStyle(color: AppColors.primary.customOpacity(0.8), fontSize: 22);

    return Expanded(
      child: Center(
        child: ClipRRect(
          child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: decoration,
              child: InkWell(
                splashColor: Colors.grey.customOpacity(0.1),
                highlightColor: AppColors.secondary.customOpacity(0.1),
                onTap: onTap,
                child: Center(
                  child: Text(text, style: buttonStyle),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Row(children: [
            _buildButton("1", onTap: () => onNumberTap("1")),
            _buildButton("2", onTap: () => onNumberTap("2")),
            _buildButton("3", onTap: () => onNumberTap("3")),
          ]),
        ),
        Expanded(
          child: Row(children: [
            _buildButton("4", onTap: () => onNumberTap("4")),
            _buildButton("5", onTap: () => onNumberTap("5")),
            _buildButton("6", onTap: () => onNumberTap("6")),
          ]),
        ),
        Expanded(
          child: Row(children: [
            _buildButton("7", onTap: () => onNumberTap("7")),
            _buildButton("8", onTap: () => onNumberTap("8")),
            _buildButton("9", onTap: () => onNumberTap("9")),
          ]),
        ),
        Expanded(
          child: Row(children: [
            _buildButton(
              "OK",
              onTap: () => onOkSubmit(),
              decoration: BoxDecoration(color: AppColors.turquoise),
            ),
            _buildButton("0", onTap: () => onNumberTap("0")),
            _buildButton("⌫",
                onTap: onBackspace,
                style: const TextStyle(fontSize: 40, color: Colors.white),
                decoration: BoxDecoration(color: AppColors.expenseColor)),
          ]),
        ),
      ],
    );
  }
}
