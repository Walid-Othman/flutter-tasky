import 'package:flutter/material.dart';
import 'package:to_do_app/Services/prefrense_manger_service.dart';
import 'package:to_do_app/core/constants/storage_key.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );
   init() {
    bool isDark = PrefrenseManger().getBool(StorageKey.isDark) ?? true;

    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme()async{
    if(themeNotifier.value == ThemeMode.dark){
      themeNotifier.value = ThemeMode.light;
      await PrefrenseManger().setBool(StorageKey.isDark, false);
  }else{
      themeNotifier.value = ThemeMode.dark;
      await PrefrenseManger().setBool(StorageKey.isDark, true);
    }
  }
  static bool isDark()=> themeNotifier.value == ThemeMode.dark;
}
