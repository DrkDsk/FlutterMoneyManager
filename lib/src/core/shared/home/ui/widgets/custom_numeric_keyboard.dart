import 'package:flutter/material.dart';


class CustomNumericKeyboard extends StatelessWidget {
  final Function(String) onNumberTap;
  final VoidCallback onBackspace;

  const CustomNumericKeyboard({
    super.key,
    required this.onNumberTap,
    required this.onBackspace,
  });

  Widget _buildButton(String text, {VoidCallback? onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: onTap,
          child: Text(text, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          _buildButton("1", onTap: () => onNumberTap("1")),
          _buildButton("2", onTap: () => onNumberTap("2")),
          _buildButton("3", onTap: () => onNumberTap("3")),
        ]),
        Row(children: [
          _buildButton("4", onTap: () => onNumberTap("4")),
          _buildButton("5", onTap: () => onNumberTap("5")),
          _buildButton("6", onTap: () => onNumberTap("6")),
        ]),
        Row(children: [
          _buildButton("7", onTap: () => onNumberTap("7")),
          _buildButton("8", onTap: () => onNumberTap("8")),
          _buildButton("9", onTap: () => onNumberTap("9")),
        ]),
        Row(children: [
          const Spacer(),
          _buildButton("0", onTap: () => onNumberTap("0")),
          _buildButton("⌫", onTap: onBackspace),
        ]),
      ],
    );
  }
}
