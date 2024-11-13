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
        title: Text(
          widget.recipe.name,
          style: Theme.of(context).textTheme.headlineLarge
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( // Recipe info.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: CarouselView(
                    itemExtent: 250,
                    shrinkExtent: 200,
                    backgroundColor: const Color(0xFFAC8964),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    children: List<Widget>.generate(widget.recipe.pictures.length, (int index) {
                      return Image.asset(widget.recipe.pictures[index]);
                    })
                  ),
                )
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.recipe.name,
              style: Theme.of(context).textTheme.bodyLarge
            ),
            const SizedBox(height: 16),
            Text(
              widget.recipe.description,
              style: Theme.of(context).textTheme.bodyMedium
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredientes',
              style: Theme.of(context).textTheme.bodyLarge
            ),
            const SizedBox(height: 10),
            Padding( // Ingredients.
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                widget.recipe.getIngredients(),
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Productos',
              style: Theme.of(context).textTheme.bodyLarge
            ),
            const SizedBox(height: 10),
            Padding( // Products.
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                widget.recipe.getProducts(),
                style: Theme.of(context).textTheme.bodyMedium
              ),
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
          child: const Icon(Icons.add),
        )
      :
        null,
    );
  }
}
