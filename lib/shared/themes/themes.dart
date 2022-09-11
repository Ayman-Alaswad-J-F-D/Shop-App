// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightMode = ThemeData(
  primarySwatch: Colors.deepPurple,
  textTheme: const TextTheme(),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 5.0,
    iconTheme: IconThemeData(
      color: Colors.indigo,
    ),
    backgroundColor: Colors.white,
    elevation: 2.0,
    // ignore: deprecated_member_use
    backwardsCompatibility: false,
    titleTextStyle: TextStyle(
      fontFamily: 'Tajawal',
      color: Colors.indigo,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedLabelStyle:
        const TextStyle(fontFamily: 'Tajawal', letterSpacing: 1.5),
    unselectedLabelStyle:
        const TextStyle(fontFamily: 'Tajawal', letterSpacing: 0.0),
    type: BottomNavigationBarType.fixed,
    elevation: 5.0,
    backgroundColor: Colors.orange,
    unselectedIconTheme: IconThemeData(color: Colors.grey.shade500),
    selectedItemColor: Colors.deepPurple,
  ),
);

///////////////////////

ThemeData darkMode = ThemeData(
  primarySwatch: Colors.deepPurple,
  // ignore: deprecated_member_use
  useTextSelectionTheme: true,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: 'Tajawal',
    ),
  ),
  scaffoldBackgroundColor: Colors.grey.shade600,
  dividerColor: Colors.deepOrange,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    elevation: 0.0,
    // ignore: deprecated_member_use
    backwardsCompatibility: false,
    // backgroundColor: HexColor('#566573'),
    titleTextStyle: TextStyle(
      fontFamily: 'Pacifico',
      color: Colors.white,
      fontSize: 20,
      // fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 5,
    // backgroundColor: HexColor('#808B96'),
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(fontFamily: 'Pacifico', letterSpacing: 1),
    unselectedLabelStyle: TextStyle(fontFamily: 'Pacifico', letterSpacing: 0.0),
    selectedItemColor: Colors.deepPurple,
    enableFeedback: true,
  ),
);
