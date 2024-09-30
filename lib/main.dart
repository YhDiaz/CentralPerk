import 'package:central_perk/models/coffe_bean_type.dart';
import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_manager.dart';
import 'package:central_perk/models/recipe_visibility.dart';
import 'package:central_perk/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:central_perk/pages/page_home.dart';

void main() {

  UserManager(); // Expert class.
  RecipeManager(); //Expert class.

  generateMyRecipes();

  runApp(const MyApp());
}

void generateMyRecipes() {
  UserManager.users[0].myRecipes.add(
    Recipe(
      name: 'Café de Olla',
      date: DateTime(2024, 8, 5),
      owner: UserManager.users[0],
      time: 15,
      description: 'Café preparado con canela y piloncillo en una olla de barro.',
      image: 'assets/icons/icon_my_coffee.jpg',
      visibility: RecipeVisibility.friendsOnly,
      coffeBean: CoffeBeanType.liberica
    )
  );

  UserManager.users[0].myRecipes.add(
    Recipe(
      name: 'Café Frappé',
      date: DateTime(2024, 9, 16),
      owner: UserManager.users[0],
      time: 10,
      description: 'Café instantáneo mezclado con agua, azúcar y hielo, batido hasta obtener una textura espumosa.',
      image: 'assets/icons/icon_my_coffee.jpg',
      visibility: RecipeVisibility.public,
      coffeBean: CoffeBeanType.java,
      favorite: true
    )
  );

  UserManager.users[0].favoriteRecipes.add(UserManager.users[0].myRecipes[1]);

  UserManager.users[0].myRecipes.add(
    Recipe(
      name: 'Café Turco',
      date: DateTime(2024, 9, 21),
      owner: UserManager.users[0],
      time: 10,
      description: 'Café finamente molido hervido con agua y azúcar en una olla especial llamada cezve.',
      image: 'assets/icons/icon_my_coffee.jpg',
      visibility: RecipeVisibility.public,
      coffeBean: CoffeBeanType.kenyaAA
    )
  );

  UserManager.users[0].myRecipes.add(
    Recipe(
      name: 'Affogato',
      date: DateTime(2024, 9, 28),
      owner: UserManager.users[0],
      time: 5,
      description: 'Un espresso vertido sobre una bola de helado de vainilla.',
      image: 'assets/icons/icon_my_coffee.jpg',
      visibility: RecipeVisibility.private,
      coffeBean: CoffeBeanType.borbon
    )
  );

  for (int i = 0; i < UserManager.users[0].myRecipes.length; i++) {
    RecipeManager.recipes.add(UserManager.users[0].myRecipes[i]);
  }  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      title: 'Central Perk',
      theme: ThemeData (
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen (
      logo: Image.asset('assets/icons/icon_central_perk_logo.png'),
      title: const Text (
        "Central Perk",
        style: TextStyle (
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFF724A22),
      showLoader: true,
      loadingText: const Text("Opening coffeehouse..."),
      navigator: const HomePage(title: 'Central Perk - Home page'),
      durationInSeconds: 1,
    );
  }
}
