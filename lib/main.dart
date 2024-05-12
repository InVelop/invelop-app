import 'package:flutter/material.dart';
import 'package:invelop/pages/home_page.dart';
import 'package:invelop/pages/login/login_page.dart';
import 'package:invelop/pages/signUp/signUp_page.dart';
import 'package:invelop/pages/transactions.dart';
import 'package:invelop/theme/invelop_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invelop',
      theme: ThemeData(
          scaffoldBackgroundColor: InVelopColors.background,
          primaryColor: InVelopColors.primary),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/sign-up': (context) => const SignUpPage(),
        '/transactions': (context) => const TransactionsPage(),
      },
    );
  }
}
