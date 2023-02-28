import 'package:flutter/material.dart';
import 'package:onlymessage/app/core/ui/styles/app_styles.dart';
import 'package:onlymessage/app/core/ui/styles/colors_app.dart';

class ThemeConfig {
  ThemeConfig._();

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: Color(0XFF5F5E6D),
      width: 2,
    ),
  );

  static final theme = ThemeData(
    scaffoldBackgroundColor: const Color(0XFF17171F),
    appBarTheme: const AppBarTheme(
      color: Color(0XFF17171F),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0XFF5F5E6D),
      ),
    ),
    primaryColor: ColorsApp.i.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.i.primary,
      primary: ColorsApp.i.primary,
      secondary: ColorsApp.i.secondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.i.primaryButton,
    ),
    inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        border: _defaultInputBorder,
        enabledBorder: _defaultInputBorder,
        focusedBorder: _defaultInputBorder,
        labelStyle: const TextStyle(
          color: Color(0XFF5F5E6D),
        )),
  );
}
