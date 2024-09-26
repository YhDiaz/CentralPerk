import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:central_perk/pages/page_home.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    // return SplashScreen
    // (
    //   seconds: 14,
    //   navigateAfterSeconds: const HomePage(title: 'Central Perk - Home page'),
    //   title: const Text('Welcome In SplashScreen'),
    //   image: Image.asset('screenshot.png'),
    //   backgroundColor: Colors.white,
    //   styleTextUnderTheLoader: const TextStyle(),
    //   photoSize: 100.0,
    //   loaderColor: Colors.red
    // );
    // return EasySplashScreen(
    //   logo: Image.network(
    //       'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
    //   title: const Text(
    //     "Title",
    //     style: TextStyle(
    //       fontSize: 18,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    //   backgroundColor: Colors.grey.shade400,
    //   showLoader: true,
    //   loadingText: const Text("Loading..."),
    //   navigator: const HomePage(title: 'Central Perk - Home page'),
    //   durationInSeconds: 5,
    // );
    return MaterialApp
    (
      title: 'Central Perk',
      theme: ThemeData
      (
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const HomePage(title: 'Central Perk - Home page'),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget
{
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
{
  @override
  Widget build(BuildContext context)
  {
    return EasySplashScreen
    (
      logo: Image.network(
          'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
      title: const Text
      (
        "Central Perk",
        style: TextStyle
        (
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFF724A22),
      showLoader: true,
      loadingText: const Text("Opening coffeehouse..."),
      navigator: const HomePage(title: 'Central Perk - Home page',),
      durationInSeconds: 5,
    );
  }
}
