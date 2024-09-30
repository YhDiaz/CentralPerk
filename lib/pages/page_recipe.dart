import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_manager.dart';
import 'package:flutter/material.dart';

// User myUser = UserManager.users[0];
List<Recipe> recipes = List.empty(growable: true);


class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.title});
  final String title;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          RecipeManager.displayRecipe.name,
        ),
      )
    );
  }
}