// import 'package:central_perk/models/coffe_bean_type.dart';
// import 'package:central_perk/models/comment.dart';
// import 'package:central_perk/models/product.dart';
// import 'package:central_perk/models/recipe.dart';
// import 'package:central_perk/models/recipe_visibility.dart';
// import 'package:central_perk/models/user.dart';
// import 'package:central_perk/models/user_manager.dart';

// class RecipeManager {
//   static List<Recipe> recipes = List.empty(growable: true);
//   static Recipe displayRecipe = Recipe(
//     name: '',
//     date: DateTime(2024),
//     owner: User(name: '', username: '', password: '', profileImage: ''),
//     time: 0,
//     description: '',
//     steps: '',
//     image: '',
//     visibility: RecipeVisibility.public,
//     coffeBean: CoffeBeanType.arabica
//   );

//   RecipeManager() {
//     recipes = _generateRecipesList();
//     _initializeRecipesCollections();
//   }

//   List<Recipe> _generateRecipesList() {
//     return [
//       _generateRecipe(
//         'Café Espresso',
//         DateTime(2024, 09, 27),
//         UserManager.users[1],
//         5,
//         'El espresso es un café concentrado y fuerte, conocido por su sabor intenso y su capa de crema en la superficie. Es la base para muchas otras bebidas de café.',
//         '1. Muele el café hasta obtener una consistencia fina.\n2. Coloca el café molido en el portafiltro y apisona firmemente.\n3. Inserta el portafiltro en la cafetera y comienza la extracción.\n4. Deja que el espresso se extraiga durante 25-30 segundos.\n5. Sirve en una taza pequeña.',
//         'assets/icons/icon_coffee_espresso.jpg',
//         RecipeVisibility.public,
//         CoffeBeanType.arabica
//       ),
//       _generateRecipe(
//         'Café Latte',
//         DateTime(2024, 09, 25),
//         UserManager.users[3],
//         10,
//         'El café latte combina un espresso con una gran cantidad de leche vaporizada, creando una bebida suave y cremosa. A menudo se sirve con una capa de espuma de leche en la parte superior.',
//         '1. Prepara un shot de espresso y viértelo en una taza grande.\n2. Calienta y vaporiza la leche hasta que esté espumosa.\n3. Vierte la leche vaporizada sobre el espresso.\n4. Opcional: Añade azúcar al gusto.',
//         'assets/icons/icon_coffee_latte.jpg',
//         RecipeVisibility.public,
//         CoffeBeanType.robusta
//       ),
//       _generateRecipe(
//         'Café Mocha',
//         DateTime(2024, 09, 24),
//         UserManager.users[3],
//         10,
//         'El café mocha es una deliciosa combinación de espresso, chocolate caliente y leche vaporizada. Es perfecto para aquellos que disfrutan de un toque de dulzura en su café.',
//         '1. Prepara un shot de espresso y viértelo en una taza.\n2. Calienta la leche y mezcla con el cacao en polvo y el azúcar.\n3. Vierte la mezcla de leche y cacao sobre el espresso.\n4. Opcional: Decora con crema batida y chocolate rallado.',
//         'assets/icons/icon_coffee_mocha.jpg',
//         RecipeVisibility.public,
//         CoffeBeanType.arabica
//       ),
//       _generateRecipe(
//         'Café Americano',
//         DateTime(2024, 09, 19),
//         UserManager.users[5],
//         5,
//         'El café americano se prepara diluyendo un espresso con agua caliente, resultando en una bebida más suave y menos concentrada que el espresso, pero con un sabor robusto.',
//         '1. Prepara un shot de espresso y viértelo en una taza grande.\n2. Añade agua caliente al espresso hasta alcanzar el volumen deseado.',
//         'assets/icons/icon_coffee_american.jpg',
//         RecipeVisibility.public,
//         CoffeBeanType.arabica
//       ),
//       _generateRecipe(
//         'Café Cappuccino',
//         DateTime(2024, 08, 31),
//         UserManager.users[2],
//         10,
//         'El cappuccino es una mezcla equilibrada de espresso, leche vaporizada y espuma de leche. Es conocido por su textura cremosa y su sabor rico.',
//         '1. Prepara un shot de espresso y viértelo en una taza de capuccino.\n2. Calienta y vaporiza la leche hasta que esté espumosa.\n3. Vierte la leche vaporizada sobre el espresso.\n4. Opcional: Espolvorea cacao en polvo o canela por encima.',
//         'assets/icons/icon_coffee_cappuccino.jpg',
//         RecipeVisibility.public,
//         CoffeBeanType.robusta
//       ),
//     ];
//   }

//   Recipe _generateRecipe(
//     String name,
//     DateTime date,
//     User user,
//     double time,
//     String description,
//     String steps,
//     String image,
//     RecipeVisibility visibility,
//     CoffeBeanType coffeBean
//     ) {
//     return Recipe(
//       name: name,
//       date: date,
//       owner: user,
//       time: time,
//       description: description,
//       steps: steps,
//       image: image,
//       visibility: visibility,
//       coffeBean: coffeBean
//     );
//   }

//   static List<Recipe> userRecipes(User user) {
//     List<Recipe> myRecipes = List.empty(growable: true);

//     for (int i = 0; i < recipes.length; i++) {
//       if (recipes[i].owner == user) {
//         myRecipes.add(recipes[i]);
//       }
//     }

//     return myRecipes;
//   }

//   static void updateRecipe(Recipe recipe) {
//     for (int i = 0; i < recipes.length; i++) {
//       if (recipes[i].id == recipe.id) {
//         recipes[i] = recipe;
//         return;
//       }
//     }
//   }

//   void _initializeRecipesCollections() {
//     // Add ingredients for recipe 1
//     recipes[0].initializeIngredients(<String>[
//       '7-12 gramos de café recién molido (preferiblemente de especialidad)',
//       'Agua purificada'
//     ]);

//     // Add artifacts for recipe 1
//     recipes[0].initializeArtifacts(<Product>[
//       Product(
//         name: 'Cafetera espresso',
//         salesperson: UserManager.users[1],
//       ),
//       Product(
//         name: 'Molino de café',
//         salesperson: UserManager.users[1],
//       ),
//       Product(
//         name: 'Tamper (apisonador de café)',
//         salesperson: UserManager.users[1],
//       ),
//       Product(
//         name: 'Taza de 50-70 ml',
//         salesperson: UserManager.users[1],
//       ),
//     ]);

//     // Add comments for recipe 1
//     recipes[0].initializeComments(<Comment>[
//       Comment(
//         owner: UserManager.users[3],
//         date: DateTime(2024, 9, 29),
//         comment: 'Me encantó la capa de crema dorada!'
//       )
//     ]);

//     // Add ingredients for recipe 2
//     recipes[1].initializeIngredients(<String>[
//       '1 shot de espresso',
//       '200 ml de leche'
//     ]);

//     // Add artifacts for recipe 2
//     recipes[1].initializeArtifacts(<Product>[
//       Product(
//         name: 'Cafetera espresso',
//         salesperson: UserManager.users[1],
//       ),
//       Product(
//         name: 'Vaporizador de leche',
//         salesperson: UserManager.users[1],
//       ),
//       Product(
//         name: 'Taza grande',
//         salesperson: UserManager.users[1],
//       ),
//     ]);

//     // Add ingredients for recipe 3
//     recipes[2].initializeIngredients(<String>[
//       '1 shot de espresso',
//       '200 ml de leche',
//       '2 cucharadas de cacao en polvo',
//       'Azúcar al gusto',
//       'Crema batida (opcional)'
//     ]);

//     // Add artifacts for recipe 3
//     recipes[2].initializeArtifacts(<Product>[
//       Product(
//         name: 'Cafetera espresso',
//         salesperson: UserManager.users[1],
//       ),
//       Product(
//         name: 'Vaporizador de leche',
//         salesperson: UserManager.users[1],
//       ),
//       Product(
//         name: 'Taza grande',
//         salesperson: UserManager.users[1],
//       ),
//     ]);
    
//     // Add comments for recipe 3
//     recipes[2].initializeComments(<Comment>[
//       Comment(
//         owner: UserManager.users[4],
//         date: DateTime(2024, 9, 30),
//         comment: 'Recomiendo para amantes del chocolate'
//       )
//     ]);

//     // Add ingredients for recipe 4
//     recipes[3].initializeIngredients(<String>[
//       '1 shot de espresso',
//       '150-200 ml de agua caliente'
//     ]);

//     // Add artifacts for recipe 4
//     recipes[3].initializeArtifacts(<Product>[
//       Product(
//         name: 'Cafetera espresso',
//         salesperson: UserManager.users[1],
//       ),
//       Product(
//         name: 'Hervidor de agua',
//         salesperson: UserManager.users[1],
//       ),
//       Product(
//         name: 'Taza grande',
//         salesperson: UserManager.users[1],
//       ),
//     ]);

//     // Add ingredients for recipe 5
//     recipes[4].initializeIngredients(<String>[
//       '1 shot de espresso',
//       '120 ml de leche',
//       'Cacao en polvo o canela (opcional)'
//     ]);

//     // Add artifacts for recipe 5
//     recipes[4].initializeArtifacts(<Product>[
//       Product(
//         name: 'Cafetera espresso',
//         salesperson: UserManager.users[1],
//       ),
//       Product(
//         name: 'Vaporizador de leche',
//         salesperson: UserManager.users[1],
//       ),
//       Product(
//         name: 'Taza de capuccino',
//         salesperson: UserManager.users[1],
//       ),
//     ]);
//   }
// }