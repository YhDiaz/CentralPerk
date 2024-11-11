import 'package:central_perk/models/recipe.dart';
import 'package:flutter/material.dart';

class MyBaristaPage extends StatefulWidget {
  const MyBaristaPage({super.key, required this.title});
  final String title;

  @override
  State<MyBaristaPage> createState() => _MyBaristaPageState();
}

class _MyBaristaPageState extends State<MyBaristaPage> {
  static const Color appBarTextColor = Color(0xFFF2E0D3);

  Future<List<Recipe>>? _recipesFuture;
  List<Recipe> _recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
    _recipes = _buildMyBaristaRecipesList();
  }

  Future<void> _loadRecipes() async {
    setState(() {
      _recipesFuture = Recipe.loadMyBaristaRecipes();
    });
  }

  void _deleteRecipe(Recipe recipe) {
    setState(() {
      _recipes.remove(recipe);
    });
  }

  List<Recipe> _buildMyBaristaRecipesList() {
    if (_recipesFuture == null) {
      return []; // Return an empty list of recipes.
    }
    _recipesFuture!.then((result) {
      for (var item in result) {
        _recipes.add(item); // Add each recipe in recipes future to list of recipes.
      }
    });
    return _recipes;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<Recipe>>(
        future: _recipesFuture, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
          Widget recipesList = _getRecipesListToDisplay(true); // Base Widget.

          if (snapshot.hasData) recipesList = _getRecipesListToDisplay(false); // List of recipes.

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontFamily: 'Lobster',
                      color: appBarTextColor
                    )
                  ),
                  const SizedBox(width: 122,),
                  Image.asset(
                    'assets/icons/icon_central_perk_logo.png',
                    fit: BoxFit.contain,
                    height: 75,
                  ),
                ],
              ),
            ),
            body: recipesList
          );
        },
      ),
    );
  }

  // Get list of My barista recipes to display.
  // defaultInfo = true: indicates that there aren't any recipes loaded yet.
  // defaultInfo = false: indicate that My barista recipes were loaded.
  Widget _getRecipesListToDisplay(bool defaultInfo) {
    return Center(
      child: Column(
              children: [
                Expanded( // To avoid problems due to include a ListView inside a Column.
                  child: SizedBox(
                    width: 350.0, // Width of list items.
                    child: ListView.builder(
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        return defaultInfo ?
                          Text('No se encontró información de la receta $index') // Recipes aren't loaded yet.
                        :
                          _recipes[index].getCard(context, _deleteRecipe); // Display recipe card.
                      },
                    )
                  ),
                )
              ],
            ),
    );
  }
}
