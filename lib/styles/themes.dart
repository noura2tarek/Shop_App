import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/Styles/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  dividerTheme: DividerThemeData(
    color: Colors.grey[200],
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white,
    ),
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    prefixIconColor: Colors.white,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  textTheme: const TextTheme(
      bodySmall: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: Colors.white,
  )),
  appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    elevation: 8.0,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
  fontFamily: 'Jannah',
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: floatingActionButtonColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9.0),
    ),
    elevation: 7.0,
  ),
);

ThemeData lightTheme = ThemeData(
  useMaterial3: false,
  primarySwatch: defaultColor,
  primaryColor: defaultColor,
  dividerTheme: DividerThemeData(
    color: Colors.grey[400],
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      //fontWeight: FontWeight.bold,
      //fontSize: 13.0,
      color: Colors.black,
    ),
  ),
  appBarTheme: const AppBarTheme(
      titleSpacing: 16.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      )),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  fontFamily: 'Jannah',
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: floatingActionButtonColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9.0),
    ),
    elevation: 7.0,
  ),
);
