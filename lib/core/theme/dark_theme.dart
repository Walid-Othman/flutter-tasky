import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xFFfcfcfc)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15886c)),
      foregroundColor: WidgetStateProperty.all(Color(0xFFfffcfc)),
    ),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? Color(0xFF15886c)
          : Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((stats) {
      return stats.contains(WidgetState.selected)
          ? Colors.white
          : Color(0xFF9E9E9E);
    }),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Color(0xFFfffcfc)),
  scaffoldBackgroundColor: Color(0xFF181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF181818),
    toolbarHeight: 4,
    centerTitle: false,
    foregroundColor: Color(0xFFfffcfc),
    titleTextStyle: TextStyle(fontSize: 20),
  ),
  textTheme: TextTheme(
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xFFfffcfc),
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xFFfffcfc),
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0xFFA0A0A0),
      fontSize: 14,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFFA0A0A0),
    ),

    titleMedium: TextStyle(
      color: Color(0xFFfffcfc),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xFFC6C6C6),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    ),
    hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
    fillColor: Color(0xFF282828),
    filled: true,
  ),
  colorScheme: ColorScheme.dark(primaryContainer: Color(0xFF282828)),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFF6E6E6E), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xFFfffcfc)),
  dividerTheme: DividerThemeData(color: Color(0xFF6E6E6E)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xFFfffcfc),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.black,
    selectionHandleColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xFF181818),
    unselectedItemColor: Color(0xFFC6C6C6),
    selectedItemColor: Color(0xFF15B86C),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFF181818),
    position: PopupMenuPosition.under,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        color: Color(0xFFfffcfc),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Color(0xFF6E6E6E)),
    ),
    elevation: 2,
    shadowColor: Color(0xFFfcfcfc),
  ),
  dialogTheme: DialogThemeData(
    shadowColor: Color(0xFFfcfcfc),
    backgroundColor: Color(0xFF181818),
    titleTextStyle: TextStyle(
      color: Color(0xFFfffcfc),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    contentTextStyle: TextStyle(
      color: Color(0xFFfffcfc),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    actionsPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.red),
    ),
  ),
);
