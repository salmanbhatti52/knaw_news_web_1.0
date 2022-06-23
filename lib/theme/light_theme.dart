import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

ThemeData light = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF8F8FA),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
     statusBarColor:Color(0xFFF8F8FA),
    ),
    iconTheme: IconThemeData(color: Colors.black,)
  ),
  fontFamily: 'OpenSans',
  primaryColor: Color(0xFFFFC403),
  secondaryHeaderColor: Color(0xFF1ED7AA),
  disabledColor: Color(0xFFBABFC4),
  backgroundColor: Color(0xFFF8F8FA),
  scaffoldBackgroundColor: Color(0xFFF8F8FA),
  errorColor: Color(0xFFE84D4F),
  brightness: Brightness.light,
  hintColor: Color(0xFF9F9F9F),
  cardColor: Colors.white,
  colorScheme: ColorScheme.light(primary: Color(0xFFFFEF7822), secondary: Color(0xFFEF7822)),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: Color(0X99FFBB01))),
);
//0xFFBABFC4