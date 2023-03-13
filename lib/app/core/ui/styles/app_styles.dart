import 'package:flutter/material.dart';
import 'package:onlymessage/app/core/ui/styles/colors_app.dart';
import 'package:onlymessage/app/core/ui/styles/text_styles.dart';

class AppStyles {
  static AppStyles? _instance;

  AppStyles._();

  static AppStyles get i {
    _instance ??= AppStyles._();
    return _instance!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: ColorsApp.i.primary,
      textStyle: TextStyles.i.textButtonLabel,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32));
}

extension AppStylesExtension on BuildContext {
  AppStyles get appStyles => AppStyles.i;
}
