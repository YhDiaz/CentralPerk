import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:central_perk/pages/page_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Recipe {
  final int? id;
  final String name;
  final String description;
  final List<String> pictures;
  final List<String> ingredients;
  final List<String> products;
  final bool myBaristaRecipe;

  static int counter = 0;

  Recipe({
    this.id,
    required this.name,
    required this.description,
    required this.pictures,
    required this.ingredients,
    required this.products,
    this.myBaristaRecipe = false
  }) {
    counter++;

    print('-------------- Recipe created --------------');
    print('* Name: ${this.name}');
    print('* Description: ${this.description}');
    print('* Pictures:');

    for (int i = 0; i < this.pictures.length; i++) {
      print('   - ${this.pictures[i]}');
    }

    print('* Ingredients:');

    for (int i = 0; i < this.ingredients.length; i++) {
      print('   - ${this.ingredients[i]}');
    }

    print('* Products:');

    for (int i = 0; i < this.products.length; i++) {
      print('   - ${this.products[i]}');
    }
  }

  // Convert to JSON.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictures': jsonEncode(pictures),
      'ingredients': jsonEncode(ingredients),
      'products': jsonEncode(products)
    };
  }

  // Convert to Recipe.
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      pictures: List<String>.from(jsonDecode(map['pictures']).map((item) => item.toString())),
      ingredients: List<String>.from(jsonDecode(map['ingredients']).map((item) => item.toString())),
      products: List<String>.from(jsonDecode(map['products']).map((item) => item.toString())),
      myBaristaRecipe: map['myBaristaRecipe'] ?? false // False by default.
    );
  }

  factory Recipe.fromMapForBarista(Map<String, dynamic> map) {
    var picturesFromJson = map['pictures'];
    var ingredientsFromJson = map['ingredients'];
    var productsFromJson = map['products'];
    List<String> picturesList = picturesFromJson.cast<String>();
    List<String> ingredientsList = ingredientsFromJson.cast<String>();
    List<String> productsList = productsFromJson.cast<String>();

    return Recipe(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      pictures: picturesList,
      ingredients: ingredientsList,
      products: productsList,
      myBaristaRecipe: map['myBaristaRecipe'] ?? true, // False by default.
    );
  }


  static Future<List<Recipe>> loadMyBaristaRecipes() async {
    final jsonString = await rootBundle.loadString('assets/json/my_barista_recipes.json');
    final List<dynamic> jsonDecoded = jsonDecode(jsonString) as List<dynamic>;
    return jsonDecoded.map((dynamic item) => Recipe.fromMapForBarista(item as Map<String, dynamic>)).toList();
  }

  Recipe copy({
    int? id,
    String? name,
    String? description,
    String? image
  }) =>
    Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      pictures: pictures,
      ingredients: ingredients,
      products: products
    );

  // Get custom card.
  // deleteRecipe function is just in case of add a recipe from My barista.
  Widget getCard(BuildContext context, Function(Recipe) deleteRecipe, Function() loadRecipes) {
    return Card(
      color: const Color(0xFFE0D0C0), // Card color.
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 10), // Vertical margin.
      child: InkWell( // To detect taps.
        onTap: () { // Behavior when touch the recipe.
          Navigator.push( // Add Recipe page to navigation stack.
            context,
            MaterialPageRoute(
              builder: (context) => RecipePage(
                recipe: this,
                fromMyBarista: myBaristaRecipe,
                moveRecipeFromMyBarista: deleteRecipe
              ),
            ),
          ).then((_) {
            loadRecipes();
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row( // Center image.
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect( // Add recipe image with rounded borders.
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4.0)), // Top card border.
                  child: Container(
                    width: 200,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: CarouselView(
                        itemExtent: 220,
                        shrinkExtent: 200,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        backgroundColor: Color(0x00FFFFFF),
                        children: List<Widget>.generate(pictures.length, (int index) {
                          return getPicture(index);
                        })
                      ),
                    ),
                  )
                ),
              ]
            ),
            Padding( // Recipe name.
              padding: const EdgeInsets.all(16.0),
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge
              ),
            ),
            Padding( // Recipe content.
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // 3 points when text is overflow.
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  String getIngredients() {
    String ingredientsText = '';

    for (int i = 0; i < this.ingredients.length; i++) {
      ingredientsText += '* ${this.ingredients[i]}';
      if (i != this.ingredients.length - 1) ingredientsText += '\n';
    }

    return ingredientsText;
  }

  String getProducts() {
    String productsText = '';

    for (int i = 0; i < this.products.length; i++) {
      productsText += '* ${this.products[i]}';
      if (i != this.products.length - 1) productsText += '\n';
    }

    return productsText;
  }

  String generateShareText() {
    return myBaristaRecipe ?
            '¡Mira la receta de Mi barista!\n\n' +
            '$name\n\n$description\n\nIngredientes:\n${getIngredients()}\n\nProductos:\n${getProducts()}\n\n' +
            'Con la aplicación Central Perk puedes inspirarte en las recetas de Mi barista para crear las tuyas propias ¡Pruébala ya!'
          :
            '¡He creado una receta de café!\n\n' +
            '$name\n\n$description\n\nIngredientes:\n${getIngredients()}\n\nProductos:\n${getProducts()}\n\n' +
            'Con la aplicación Central Perk es sencillo crear recetas y personalizarlas a tu gusto ¡Pruébala ya!';
  }

  String getIngredientsTextField() {
    String ingredientsText = '';

    for (int i = 0; i < this.ingredients.length; i++) {
      ingredientsText += '${this.ingredients[i]}';
      if (i != this.ingredients.length - 1) ingredientsText += ',';
    }

    return ingredientsText;
  }

  String getProductsTextField() {
    String productsText = '';

    for (int i = 0; i < this.products.length; i++) {
      productsText += '${this.products[i]}';
      if (i != this.products.length - 1) productsText += ',';
    }

    return productsText;
  }

  Image getPicture(int index) {
    if (this.pictures[index].contains('assets')) return Image.asset(pictures[index]);
    return Image.file(File(pictures[index]));
  }
}
