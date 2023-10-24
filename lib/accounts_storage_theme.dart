import 'package:flutter/material.dart';

class AccountsTheme {
  final theme = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.white),
          color: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)))),
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.white));
}
