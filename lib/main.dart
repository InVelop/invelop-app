import 'package:flutter/material.dart';
import 'package:invelop/pages/home_page.dart';
import 'package:invelop/pages/login/login_page.dart';
import 'package:invelop/theme/invelop_colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: InVelopColors.background,
          primaryColor: InVelopColors.primary),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
