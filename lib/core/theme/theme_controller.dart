import 'package:flutter/material.dart';
import 'package:to_do_app/Services/prefrense_manger_service.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );
   init() {
    bool isDark = PrefrenseManger().getBool("isDark") ?? true;

    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme()async{
    if(themeNotifier.value == ThemeMode.dark){
      themeNotifier.value = ThemeMode.light;
      await PrefrenseManger().setBool('isDark', false);
  }else{
      themeNotifier.value = ThemeMode.dark;
      await PrefrenseManger().setBool('isDark', true);
    }
  }
  static bool isDark()=> themeNotifier.value == ThemeMode.dark;
}
