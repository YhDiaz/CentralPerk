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
    return MaterialApp
    (
      title: 'Central Perk',
      theme: ThemeData
      (
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
  // static const String centralPerkLogoPath = 'assets/icons/icon_central_perk_logo.svg';
  // final Widget centralPerkLogo = SvgPicture.asset(
  //   centralPerkLogoPath,
  //   semanticsLabel: 'Central Perk Logo'
  // );

  @override
  Widget build(BuildContext context)
  {
    return EasySplashScreen
    (
      // logo: Image.network(
      //     'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
      // logo: Image.asset('assets/icons/icon_central_perk_logo.png'),
      logo: Image.asset('assets/icons/icon_central_perk_logo.png'),
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
