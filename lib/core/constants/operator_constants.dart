import 'package:flutter/material.dart';

class OperatorConstants {
  static const Map<String, Color> operatorColors = {
    'ORANGE MONEY': Color(0xFFFF6B00), // Orange
    'MPESA': Color(0xFF4CAF50),        // Vert
    'AIRTEL MONEY': Color(0xFFE53935),  // Rouge
  };

  static const Map<String, String> operatorEmojis = {
    'ORANGE MONEY': '🟠',
    'MPESA': '🟢',
    'AIRTEL MONEY': '🔴',
  };

  static String formatOperatorForDiscord(String operator) {
    final emoji = operatorEmojis[operator] ?? '⚪';
    return '$emoji **$operator**';
  }

  static Color getOperatorColor(String operator) {
    return operatorColors[operator] ?? Colors.grey;
  }
}
