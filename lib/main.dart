import 'package:flutter/material.dart';
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
      home: const MyHomePage(title: 'Central Perk - Home page'),
    );
  }
}
