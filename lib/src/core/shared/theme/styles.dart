import 'package:flutter/material.dart';

BoxDecoration defaultBorder = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.grey.shade200),
    boxShadow: [
      BoxShadow(
          color: Colors.grey.shade100,
          offset: const Offset(0, 3),
          blurRadius: 0.5
      )
    ]
);