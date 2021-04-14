import 'package:Shrine/supplemental/cut_corners_border.dart';
import 'package:flutter/material.dart';

const kShrinePink50 = Color(0xFFFEEAE6);
const kShrinePink100 = Color(0xFFFEDBD0);
const kShrinePink300 = Color(0xFFFBB8AC);
const kShrinePink400 = Color(0xFFEAA4A4);

const kShrineBrown900 = Color(0xFF442B2D);

const kShrineErrorRed = Color(0xFFC5032B);

const kShrineSurfaceWhite = Color(0xFFFFFBFA);
const kShrineBackgroundWhite = Colors.white;

final ThemeData lightTheme = _buildShrineLightTheme();

ThemeData _buildShrineLightTheme() {
  var base = ThemeData.light();
  return base.copyWith(
    accentColor: kShrineBrown900,
    primaryColor: kShrinePink100,
    buttonTheme: base.buttonTheme.copyWith(
        buttonColor: kShrinePink100,
        colorScheme: base.colorScheme.copyWith(secondary: kShrineBrown900)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      primary: kShrinePink100,
      onPrimary: kShrineBrown900,
    )),
    textButtonTheme: TextButtonThemeData(
        style: ElevatedButton.styleFrom(
      onPrimary: kShrineBrown900,
    )),
    buttonBarTheme:
        base.buttonBarTheme.copyWith(buttonTextTheme: ButtonTextTheme.accent),
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    cardColor: kShrineBackgroundWhite,
    errorColor: kShrineErrorRed,
    textSelectionTheme: TextSelectionThemeData(selectionColor: kShrinePink100),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(color: kShrineBrown900),
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(),
      focusedBorder: CutCornersBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: kShrineBrown900
        )
      ),
    )
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(fontWeight: FontWeight.w500),
        headline6: base.headline6.copyWith(fontSize: 18),
        caption:
            base.caption.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
        bodyText1:
            base.bodyText1.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
      )
      .apply(
          fontFamily: 'Rubik',
          displayColor: kShrineBrown900,
          bodyColor: kShrineBrown900);
}
