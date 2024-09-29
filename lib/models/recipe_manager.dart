import 'package:central_perk/models/coffe_bean_type.dart';
import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_visibility.dart';
import 'package:central_perk/models/user.dart';
import 'package:central_perk/models/user_manager.dart';

class RecipeManager {
  static List<Recipe> recipes = List.empty(growable: true);

  RecipeManager() {
    recipes = _generateRecipesList();

    // print('Name from recipe 1: ' + recipes[0].owner.name);
  }

  List<Recipe> _generateRecipesList() {
    return [
      _generateRecipe(
        'Café Espresso',
        DateTime(2024, 09, 27),
        UserManager.users[0],
        5,
        'El espresso es un café concentrado y fuerte, conocido por su sabor intenso y su capa de crema en la superficie. Es la base para muchas otras bebidas de café.',
        'assets/icons/icon_coffee_espresso.jpg',
        RecipeVisibility.public,
        CoffeBeanType.arabica
      ),
      _generateRecipe(
        'Café Latte',
        DateTime(2024, 09, 25),
        UserManager.users[2],
        10,
        'El café latte combina un espresso con una gran cantidad de leche vaporizada, creando una bebida suave y cremosa. A menudo se sirve con una capa de espuma de leche en la parte superior.',
        'assets/icons/icon_coffee_latte.jpg',
        RecipeVisibility.public,
        CoffeBeanType.robusta
      ),
      _generateRecipe(
        'Café Mocha',
        DateTime(2024, 09, 24),
        UserManager.users[2],
        10,
        'El café mocha es una deliciosa combinación de espresso, chocolate caliente y leche vaporizada. Es perfecto para aquellos que disfrutan de un toque de dulzura en su café.',
        'assets/icons/icon_coffee_mocha.jpg',
        RecipeVisibility.public,
        CoffeBeanType.arabica
      ),
      _generateRecipe(
        'Café Americano',
        DateTime(2024, 09, 19),
        UserManager.users[4],
        5,
        'El café americano se prepara diluyendo un espresso con agua caliente, resultando en una bebida más suave y menos concentrada que el espresso, pero con un sabor robusto.',
        'assets/icons/icon_coffee_american.jpg',
        RecipeVisibility.public,
        CoffeBeanType.arabica
      ),
      _generateRecipe(
        'Café Cappuccino',
        DateTime(2024, 08, 31),
        UserManager.users[1],
        10,
        'El cappuccino es una mezcla equilibrada de espresso, leche vaporizada y espuma de leche. Es conocido por su textura cremosa y su sabor rico.',
        'assets/icons/icon_coffee_cappuccino.jpg',
        RecipeVisibility.public,
        CoffeBeanType.robusta
      ),
    ];
  }

  Recipe _generateRecipe(
    String name,
    DateTime date,
    User user,
    double time,
    String description,
    String image,
    RecipeVisibility visibility,
    CoffeBeanType coffeBean
    ) {
    return Recipe(
      name: name,
      date: date,
      owner: user,
      time: time,
      description: description,
      image: image,
      visibility: visibility,
      coffeBean: coffeBean
    );
  }
}