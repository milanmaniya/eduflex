import 'package:flutter/material.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    selectedColor: Colors.blue,
    checkmarkColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 12,
    ),
    labelStyle: const TextStyle(
      color: Colors.black,
    ),
  );
  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: Colors.grey,
    selectedColor: Colors.blue,
    checkmarkColor: Colors.white,
    padding: EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 12,
    ),
    labelStyle: TextStyle(
      color: Colors.white,
    ),
  );
}
