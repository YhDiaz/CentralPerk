import 'package:central_perk/models/coffe_bean_type.dart';
import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_manager.dart';
import 'package:central_perk/models/recipe_visibility.dart';
import 'package:central_perk/models/user.dart';
import 'package:central_perk/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:central_perk/pages/page_home.dart';

// List<Recipe> recipes = [
//   Recipe(
//     name: 'Café Espresso',
//     date: DateTime(2024, 09, 27),
//     // owner: users[0],
//     owner: UserManager.users[0],
//     time: 5,
//     description: 'El espresso es un café concentrado y fuerte, conocido por su sabor intenso y su capa de crema en la superficie. Es la base para muchas otras bebidas de café.',
//     image: 'assets/icons/icon_coffee_espresso.jpg',
//     visibility: RecipeVisibility.public,
//     coffeBean: CoffeBeanType.arabica
//   ),
//   Recipe(
//     name: 'Café Latte',
//     date: DateTime(2024, 09, 25),
//     // owner: users[1],
//     owner: UserManager.users[1],
//     time: 10,
//     description: 'El café latte combina un espresso con una gran cantidad de leche vaporizada, creando una bebida suave y cremosa. A menudo se sirve con una capa de espuma de leche en la parte superior.',
//     image: 'assets/icons/icon_coffee_latte.jpg',
//     visibility: RecipeVisibility.public,
//     coffeBean: CoffeBeanType.robusta
//   ),
//   Recipe(
//     name: 'Café Mocha',
//     date: DateTime(2024, 09, 24),
//     // owner: users[2],
//     owner: UserManager.users[2],
//     time: 10,
//     description: 'El café mocha es una deliciosa combinación de espresso, chocolate caliente y leche vaporizada. Es perfecto para aquellos que disfrutan de un toque de dulzura en su café.',
//     image: 'assets/icons/icon_coffee_mocha.jpg',
//     visibility: RecipeVisibility.public,
//     coffeBean: CoffeBeanType.arabica
//   ),
//   Recipe(
//     name: 'Café Americano',
//     date: DateTime(2024, 09, 19),
//     // owner: users[3],
//     owner: UserManager.users[3],
//     time: 5,
//     description: 'El café americano se prepara diluyendo un espresso con agua caliente, resultando en una bebida más suave y menos concentrada que el espresso, pero con un sabor robusto.',
//     image: 'assets/icons/icon_coffee_american.jpg',
//     visibility: RecipeVisibility.public,
//     coffeBean: CoffeBeanType.arabica
//   ),
//   Recipe(
//     name: 'Café Cappuccino',
//     date: DateTime(2024, 08, 31),
//     // owner: users[4],
//     owner: UserManager.users[4],
//     time: 10,
//     description: 'El cappuccino es una mezcla equilibrada de espresso, leche vaporizada y espuma de leche. Es conocido por su textura cremosa y su sabor rico.',
//     image: 'assets/icons/icon_coffee_cappuccino.jpg',
//     visibility: RecipeVisibility.public,
//     coffeBean: CoffeBeanType.robusta
//   ),
// ];


void main() {

  UserManager(); // Expert class.
  RecipeManager(); //Expert class.
  runApp(const MyApp());
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
      navigator: HomePage(title: 'Central Perk - Home page'/*, resp: recipes,*/),
      durationInSeconds: 5,
    );
  }
}
