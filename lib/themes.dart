

import 'package:flutter/material.dart';

ThemeData lightMode=ThemeData(
  colorScheme: ColorScheme.light(
    primary:Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    inversePrimary: Colors.grey.shade900,
    surface: Colors.grey.shade300
  )
);


ThemeData darkMode=ThemeData(
    colorScheme: ColorScheme.dark(
        primary:Colors.grey.shade600,
        secondary: Colors.grey.shade800,
        inversePrimary: Colors.grey.shade300,
        surface: Colors.grey.shade900
    )
);