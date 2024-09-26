
import 'package:flutter/material.dart';

import 'colors_palette.dart';

class ApplicationThemeManager {


  static ThemeData themeData = ThemeData(
    primaryColor: ColorPalette.primaryColor,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(
          fontFamily: "Exo",
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.white
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 35,
      ),
      backgroundColor: ColorPalette.primaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
      ),
    )
  );

}