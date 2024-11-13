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
      theme: _getColorPalette(),
      home: const HomePage(title: 'Principal')
    );
  }

  // Get app color palette.
  ThemeData _getColorPalette() {
    return ThemeData(
      primaryColor: const Color(0xFF543C2E),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFF533424), // Buttons like Add and Cancel in pop-ups.
      ),
      scaffoldBackgroundColor: const Color(0xFFD3B391), // Scaffold theme.
      appBarTheme: const AppBarTheme( // App bar theme.
        backgroundColor: Color(0xFF66280a)
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Lobster',
          fontSize: 28,
          color: Color(0xFFF2E0D3)
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'DancingScript',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF794024)
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF794024)
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15,
          color: Color(0xFF794024)
        )
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFB48E6E),
        textTheme: ButtonTextTheme.primary
      )
    );
  }
}
