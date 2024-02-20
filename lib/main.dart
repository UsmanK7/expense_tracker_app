import 'package:expense_tracker_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/services/theme_mode.dart';
import 'package:get/get.dart';
import 'package:expense_tracker_app/const/theme.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      
      darkTheme: Themes.dark,

      themeMode: ThemeServices().theme,
      home: HomeScreen(),
    );
  }
}