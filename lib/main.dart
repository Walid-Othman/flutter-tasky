import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Services/prefrense_manger_service.dart';
import 'package:to_do_app/core/Controllers/data_controller.dart';
import 'package:to_do_app/core/Controllers/profile_controller.dart';
import 'package:to_do_app/core/constants/storage_key.dart';
import 'package:to_do_app/core/theme/dark_theme.dart';
import 'package:to_do_app/core/theme/light_theme.dart';
import 'package:to_do_app/core/theme/theme_controller.dart';
import 'package:to_do_app/core/features/Navigation/main_screen.dart';
import 'package:to_do_app/core/features/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final userToken = pref.getString(StorageKey.autToken);
  await ScreenUtil.ensureScreenSize();
  await PrefrenseManger().init();
  ThemeController().init();

  runApp(MyApp(userToken: userToken));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.userToken});
  final String? userToken;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode value, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => DataController()),
            ChangeNotifierProvider(
              create: (_) => ProfileController()..getProfile(),
            ),
          ],
          child: ScreenUtilInit(
            designSize: Size(375, 809),
            minTextAdapt: true,
            builder: (ctx, _) {
              return MaterialApp(
                title: 'Tasky',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: value,
                debugShowCheckedModeBanner: false,
                home: userToken == null ? WelcomeScreen() : MainScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
