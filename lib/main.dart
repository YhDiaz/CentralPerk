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
          fontFamily: 'DancingScript',
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'DancingScript',
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15,
          color: Color(0xFF794024)
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 12,
          color: Color(0xFF5F2101)
        )
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFB48E6E),
        textTheme: ButtonTextTheme.primary
      )
    );
  }
}
