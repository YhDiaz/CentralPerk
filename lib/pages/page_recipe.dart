import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_database.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  final Function(Recipe) moveRecipeFromMyBarista;
  final bool fromMyBarista;

  RecipePage({
    required this.recipe,
    required this.moveRecipeFromMyBarista,
    this.fromMyBarista = false
  });

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final RecipeDatabase recipeDatabase = RecipeDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( // Recipe info.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  widget.recipe.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.recipe.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              widget.recipe.description,
              style: const TextStyle(fontSize: 16, color: Color(0xFF794024)),
            ),
          ],
        ),
      ),
      floatingActionButton: widget.fromMyBarista ?
        FloatingActionButton( // Add recipe from My barista to My recipes.
          onPressed: () async {
            await recipeDatabase.createRecipe(widget.recipe); // Add recipe to database.
            widget.moveRecipeFromMyBarista(widget.recipe); // Move recipe from My barista, i.e., remove from My barista.
            ScaffoldMessenger.of(context).showSnackBar( // Display message at the bottom of the screen.
              const SnackBar(
                content: Text(
                  'Agregaste una receta de Mi barista a Mis recetas',
                  style: TextStyle(
                    color: Color(0xFFE7D0AE)
                  ),
                ),
                backgroundColor: Color(0xFF7C5635),
              )
            );
            // Poner la funcionalidad para mover a mis receta, hay que ver bien si se necesita la database xq hay que agregar el bool de que pertenece al barista
          },
          child: const Icon(Icons.add)
        )
      :
        null
    );
  }
}
