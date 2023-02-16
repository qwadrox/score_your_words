import 'package:flutter/material.dart';

class AppSizes {
  static const int splashScreenTitleFontSize = 48;
  static const double buttonFontSize = 18;
  static const double bodyTextFontSize = 16;
  static const double headlineFontSize = 22;
  static const double snackBarFontSize = 16;
  static const EdgeInsets layoutPadding = EdgeInsets.symmetric(horizontal: 10);
}

class AppColors {
  static const textColor = Color.fromARGB(255, 128, 128, 128);
  static const headLineColor = Color.fromARGB(255, 30, 30, 30);
  static const headLineHighlightColor = Color.fromARGB(255, 249, 100, 0);
  static const white = Color.fromARGB(255, 255, 255, 255);
  static const primaryGreen = Color(0xFF7AC142);
  static const secondaryGreen = Color(0xFF006F51);
}

class ScoreYourWordsTheme {
  // ignore: long-method
  static ThemeData of(context) {
    var theme = Theme.of(context);
    return theme.copyWith(
        snackBarTheme: theme.snackBarTheme.copyWith(
            backgroundColor: AppColors.secondaryGreen,
            actionTextColor: AppColors.white,
            contentTextStyle:
                const TextStyle(fontSize: AppSizes.snackBarFontSize, color: Colors.white, fontWeight: FontWeight.bold)),
        colorScheme: theme.colorScheme.copyWith(primary: AppColors.primaryGreen, secondary: AppColors.secondaryGreen),
        textTheme: theme.textTheme.copyWith(
          headline1: theme.textTheme.headline1?.copyWith(
            color: AppColors.headLineColor,
            fontSize: AppSizes.headlineFontSize,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w500,
          ),
           headline2: theme.textTheme.headline2?.copyWith(
            color: AppColors.headLineHighlightColor,
            fontSize: AppSizes.headlineFontSize,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w500,
          ),
          button: theme.textTheme.button?.copyWith(
            fontSize: AppSizes.buttonFontSize,
            color: AppColors.white,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w500,
          ),
          bodyText1: theme.textTheme.bodyText1?.copyWith(
            color: AppColors.textColor,
            fontSize: AppSizes.bodyTextFontSize,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w400,
          ),
        ));
  }
}
