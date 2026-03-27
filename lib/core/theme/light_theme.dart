import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xFF161f18)),
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
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.blue[800]),
  scaffoldBackgroundColor: Color(0xFFf6f7f9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    toolbarHeight: 4,
    centerTitle: true,
    foregroundColor: Color(0xFF161f18),
    titleTextStyle: TextStyle(fontSize: 20, color: Color(0xFF161f18)),
  ),
  textTheme: TextTheme(
    displayMedium: TextStyle(
      fontSize: 28.sp,
      color: Color(0xFF161f18),
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 24.sp,
      color: Color(0xFF161f18),
      fontWeight: FontWeight.w400,
    ),
    // done task
    titleLarge: TextStyle(
      color: Color(0xFFA6A6A6),
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF494949),
    ),
    titleMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xFF3A4640),
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    // enabledBorder: InputBorder.none,
    border: OutlineInputBorder(
      // borderSide: BorderSide(color: Color(0xFFD1DAD6)),
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    ),

    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    fillColor: Color(0xFFffffff),
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  colorScheme: ColorScheme.light(primaryContainer: Color(0xFFffffff)),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xFF3A4640)),
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.white,
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xFFf6f7f9),
    unselectedItemColor: Color(0xFF3A4640),
    selectedItemColor: Color(0xFF14A66c),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFf6f7f9),
    position: PopupMenuPosition.under,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        color: Color(0xFF161F1B),
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Color(0xFF6E6E6E)),
    ),
    elevation: 2,
    shadowColor: Color(0xFF6E6E6E),
  ),
  dialogTheme: DialogThemeData(
    shadowColor: Color(0xFF6E6E6E),
    backgroundColor: Color(0xFFf6f7f9),
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
    ),
    contentTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    actionsPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.red),
    ),
  ),
);
