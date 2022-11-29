import 'package:flutter/material.dart';

import '../widgets/back_button.dart';

ThemeData buildThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: "JosefinSans",
        fontWeight: FontWeight.w600,
        fontSize: 52,
        color: Color(0xff3472A1),
      ),
      displayMedium: TextStyle(
        fontFamily: "JosefinSans",
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Color(0xff444444),
      ),
      bodyLarge: TextStyle(
        fontSize: 22,
        fontFamily: "JosefinSans",
        fontWeight: FontWeight.w700,
        color: Color(0xff444444),
      ),
      bodyMedium: TextStyle(
        fontSize: 20,
        fontFamily: "JosefinSans",
        fontWeight: FontWeight.w600,
        color: Color(0xff373737),
      ),
      bodySmall: TextStyle(
        fontSize: 18,
        color: Color(0xff3472A1),
        fontFamily: "JosefinSans",
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      toolbarHeight: 120,
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: const Size(300, 70),
        primary: const Color(0xff2D87E1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontFamily: "JosefinSans",
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        fixedSize: const Size(300, 70),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey.shade600,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 18,
          fontFamily: "JosefinSans",
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: BackButtonCustom(),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            alignment: Alignment.center,
            height: 30,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
      ],
    ),
  );
}
