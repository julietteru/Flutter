import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeColors {
  static const accent = Color(0xFFFF9900);
  static const primary = Color(0xFF232F3E);
  static const primaryVariant = Color(0xFF131422);

  static const error = Color(0xFFCC1313);

  static const text = Colors.white;
}

class ThemeBuilder {
  static ThemeData build(BuildContext context) {
    var base = Theme.of(context);
    return base.copyWith(
        appBarTheme: base.appBarTheme.copyWith(
            iconTheme: IconThemeData(color: ThemeColors.text), elevation: 0),
        primaryColor: ThemeColors.primary,
        accentColor: ThemeColors.accent,
        buttonTheme: base.buttonTheme.copyWith(
            buttonColor: ThemeColors.accent,
            colorScheme: base.buttonTheme.colorScheme
                .copyWith(secondary: ThemeColors.accent)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: ThemeColors.accent,
                onPrimary: ThemeColors.text,
                padding: EdgeInsets.symmetric(vertical: 15))),
        scaffoldBackgroundColor: ThemeColors.primary,
        cardColor: ThemeColors.primaryVariant,
        errorColor: ThemeColors.error,
        textTheme: _buildPrimaryTextTheme(base.textTheme),
        primaryTextTheme: _buildPrimaryTextTheme(base.primaryTextTheme),
        accentTextTheme: _buildPrimaryTextTheme(base.primaryTextTheme),
        iconTheme: base.iconTheme.copyWith(color: ThemeColors.text, size: 35),
        inputDecorationTheme: base.inputDecorationTheme.copyWith(
          fillColor: ThemeColors.primaryVariant,
          filled: true,
          labelStyle: TextStyle(
            fontSize: 18,
            color: ThemeColors.text,
          ),
          suffixStyle: TextStyle(color: ThemeColors.text),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ThemeColors.text, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ThemeColors.text, width: 3, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
            color: ThemeColors.error,
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
        ));
  }

  static TextTheme _buildPrimaryTextTheme(TextTheme base) {
    return base
        .copyWith(
          bodyText1: base.bodyText1
              .copyWith(fontWeight: FontWeight.normal, fontSize: 16),
          headline1: base.headline1
              .copyWith(fontSize: 40, fontWeight: FontWeight.w600),
          headline2: base.headline2
              .copyWith(fontSize: 30, fontWeight: FontWeight.w600),
          headline3: base.headline3
              .copyWith(fontSize: 20, fontWeight: FontWeight.normal),
          headline6: base.headline6
              ?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
          headline4: base.headline4
              .copyWith(fontSize: 18, fontWeight: FontWeight.normal),
          headline5: base.headline5.copyWith(
              decoration: TextDecoration.underline,
              fontStyle: FontStyle.italic,
              fontSize: 18),
          button: base.button
              ?.copyWith(fontSize: 20, fontWeight: FontWeight.normal),
        )
        .apply(
            displayColor: ThemeColors.text,
            decorationColor: ThemeColors.text,
            bodyColor: ThemeColors.text);
  }
}
