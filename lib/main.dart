import 'package:central_perk/models/coffe_bean_type.dart';
import 'package:central_perk/models/comment.dart';
import 'package:central_perk/models/product.dart';
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
      steps: '1. En una olla de barro, hierve el agua con la canela, los clavos y el piloncillo.\n2. Añade el café molido y deja hervir a fuego lento durante 5 minutos.\n3. Retira del fuego y deja reposar unos minutos.\n4. Cuela y sirve en una taza grande.',
      image: 'assets/icons/icon_my_coffee.jpg',
      visibility: RecipeVisibility.friendsOnly,
      coffeBean: CoffeBeanType.liberica
    )
  );

  // Add ingredients for recipe 1
  UserManager.users[0].myRecipes[0].initializeIngredients(<String>[
    '1 litro de agua',
    '50 gramos de café molido grueso',
    '1 piloncillo (panela)',
    '1 rama de canela',
    '2 clavos de olor'
  ]);

  // Add artifacts for recipe 1
  UserManager.users[0].myRecipes[0].initializeArtifacts(<Product>[
    Product(
      name: 'Olla de barro',
      salesperson: UserManager.users[1],
    ),
    Product(
      name: 'Cuchara de madera',
      salesperson: UserManager.users[1],
    ),
    Product(
      name: 'Taza grande',
      salesperson: UserManager.users[1],
    ),
  ]);

  // Add comments for recipe 1
  UserManager.users[0].myRecipes[0].initializeComments(<Comment>[
    Comment(
      owner: UserManager.users[5],
      date: DateTime(2024, 8, 30),
      comment: 'Un buen café para iniciar la mañana'
    )
  ]);

  UserManager.users[0].myRecipes.add(
    Recipe(
      name: 'Café Frappé',
      date: DateTime(2024, 9, 16),
      owner: UserManager.users[0],
      time: 10,
      description: 'Café instantáneo mezclado con agua, azúcar y hielo, batido hasta obtener una textura espumosa.',
      steps: '1. Prepara un shot de espresso y déjalo enfriar.\n2. En una licuadora, mezcla el espresso, la leche, el hielo y el azúcar.\n3. Licúa hasta obtener una consistencia suave.\n4. Sirve en un vaso alto y decora con crema batida si lo deseas.',
      image: 'assets/icons/icon_my_coffee.jpg',
      visibility: RecipeVisibility.public,
      coffeBean: CoffeBeanType.java,
      favorite: true
    )
  );

  // Mark second recipe as favorite.
  UserManager.users[0].favoriteRecipes.add(UserManager.users[0].myRecipes[1]);

  // Add ingredients for recipe 2
  UserManager.users[0].myRecipes[1].initializeIngredients(<String>[
    '1 shot de espresso',
    '200 ml de leche',
    'Hielo',
    'Azúcar al gusto',
    'Crema batida (opcional)'
  ]);

  // Add artifacts for recipe 2
  UserManager.users[0].myRecipes[1].initializeArtifacts(<Product>[
    Product(
      name: 'Cafetera espresso',
      salesperson: UserManager.users[1],
    ),
    Product(
      name: 'Licuadora',
      salesperson: UserManager.users[1],
    ),
    Product(
      name: 'Vaso alto',
      salesperson: UserManager.users[1],
    ),
  ]);

  UserManager.users[0].myRecipes.add(
    Recipe(
      name: 'Café Turco',
      date: DateTime(2024, 9, 21),
      owner: UserManager.users[0],
      time: 10,
      description: 'Café finamente molido hervido con agua y azúcar en una olla especial llamada cezve.',
      steps: '1. En el cezve, mezcla el agua, el café y el azúcar.\n2. Calienta a fuego lento hasta que comience a formar espuma.\n3. Retira del fuego antes de que hierva y deja reposar.\n4. Repite el proceso dos veces más.\n5. Sirve en una taza pequeña.',
      image: 'assets/icons/icon_my_coffee.jpg',
      visibility: RecipeVisibility.public,
      coffeBean: CoffeBeanType.kenyaAA
    )
  );

  // Add ingredients for recipe 3
  UserManager.users[0].myRecipes[2].initializeIngredients(<String>[
    '1 taza de agua',
    '1-2 cucharadas de café molido muy fino',
    'Azúcar al gusto (opcional)',
    'Cardamomo (opcional)'
  ]);

  // Add artifacts for recipe 3
  UserManager.users[0].myRecipes[2].initializeArtifacts(<Product>[
    Product(
      name: 'Cezve (cafetera turca)',
      salesperson: UserManager.users[1],
    ),
    Product(
      name: 'Taza pequeña',
      salesperson: UserManager.users[1],
    ),
  ]);

  UserManager.users[0].myRecipes.add(
    Recipe(
      name: 'Affogato',
      date: DateTime(2024, 9, 28),
      owner: UserManager.users[0],
      time: 5,
      steps: '1. Coloca una bola de helado de vainilla en una taza pequeña.\n2. Prepara un shot de espresso y viértelo sobre el helado.',
      description: 'Un espresso vertido sobre una bola de helado de vainilla.',
      image: 'assets/icons/icon_my_coffee.jpg',
      visibility: RecipeVisibility.private,
      coffeBean: CoffeBeanType.borbon
    )
  );

  // Add ingredients for recipe 4
  UserManager.users[0].myRecipes[3].initializeIngredients(<String>[
    '1 shot de espresso',
    '1 bola de helado de vainilla'
  ]);

  // Add artifacts for recipe 4
  UserManager.users[0].myRecipes[3].initializeArtifacts(<Product>[
    Product(
      name: 'Cafetera espresso',
      salesperson: UserManager.users[1],
    ),
    Product(
      name: 'Taza pequeña',
      salesperson: UserManager.users[1],
    ),
  ]);
  
  // Add comments for recipe 4
  UserManager.users[0].myRecipes[3].initializeComments(<Comment>[
    Comment(
      owner: UserManager.users[3],
      date: DateTime(2024, 9, 24),
      comment: 'Sencillo y delicioso'
    ),
    Comment(
      owner: UserManager.users[5],
      date: DateTime(2024, 9, 26),
      comment: 'El helado le da el toque'
    ),
  ]);

  // Add main user recipes to recipes list in Recipe Manager.
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
