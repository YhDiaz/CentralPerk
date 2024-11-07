import 'package:flutter/material.dart';
import 'package:central_perk/pages/page_home.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      title: 'Central Perk',
      theme: ThemeData(
        primaryColor: const Color(0xFF543C2E),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFDD8051),
        ),
        scaffoldBackgroundColor: const Color(0xFFD3B391), // Scaffold theme.
        appBarTheme: const AppBarTheme( // App bar theme.
          backgroundColor: Color(0xFF66280a)
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Color(0xFF794024)
          ),
          bodyMedium: const TextStyle(
            color: Color(0xFF5F2101)
          )
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFFB48E6E),
          textTheme: ButtonTextTheme.primary
        )
      ),
      home: const HomePage(title: 'Central perk - Home page')
    );
  }
}
