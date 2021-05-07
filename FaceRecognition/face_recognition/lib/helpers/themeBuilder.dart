import 'package:flutter/material.dart';

class ThemeBuilder {

  static ThemeData build(BuildContext context){
    var theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Color(0xFF00796b),
      accentColor: Color(0xFFf57c00),
    );
  }
}