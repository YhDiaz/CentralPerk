import 'dart:convert';

import 'package:central_perk/pages/page_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

class Recipe {
  final int? id;
  final String name;
  final String description;
  final String image;
  final bool myBaristaRecipe;

  Recipe({
    this.id,
    required this.name,
    required this.description,
    required this.image,
    this.myBaristaRecipe = false
  });

  // Convert to JSON.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image
    };
  }

  // Convert to Recipe.
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      myBaristaRecipe: map['myBaristaRecipe'] ?? false // False by default.
    );
  }

  factory Recipe.fromMapForBarista(Map<String, dynamic> map) {
    return Recipe(
      name: map['name'],
      description: map['description'],
      image: map['image'],
      myBaristaRecipe: map['myBaristaRecipe'] ?? true // True by default.
    );
  }

  static Future<List<Recipe>> loadMyBaristaRecipes() async {
    final jsonString = await rootBundle.loadString('assets/json/my_barista_recipes_simple.json');
    // final jsonString = await rootBundle.loadString('assets/json/my_barista_recipes.json');
    final List<dynamic> jsonDecoded = jsonDecode(jsonString) as List<dynamic>;
    print("test----:"+jsonDecoded.toString());
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
      image: image ?? this.image
    );

  // Get custom card.
  // deleteRecipe function is just in case of add a recipe from My barista.
  Widget getCard(BuildContext context, Function(Recipe) deleteRecipe) {
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
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center( // Center image.
                    child: ClipRRect( // Add recipe image with rounded borders.
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4.0)), // Top card border.
                      child: Image.asset(
                        image,
                        width: 350,
                        height: 250,
                        fit: BoxFit.cover, // To adjust image to container.
                      ),
                    ),
                  ),
                  Padding( // Recipe name.
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding( // Recipe content.
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      description,
                      style: const TextStyle(fontSize: 16, color: const Color(0xFF674722)),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
  }
}
