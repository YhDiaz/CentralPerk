import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_database.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class RecipePage extends StatefulWidget {
  Recipe recipe;
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

  Future<void> _loadRecipe() async {
    final dbHelper = RecipeDatabase.instance;
    final _recipe = await dbHelper.readRecipe(widget.recipe.id!);
    
    setState(() {
      widget.recipe = _recipe;
    });
  }

  Future<void> _updateRecipe(Recipe recipe) async {
    final dbHelper = RecipeDatabase.instance;
    await dbHelper.updateRecipe(recipe);
    _loadRecipe(); // Refresh recipes list.
  }

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
            Row( // Top recipe information and options.
              children: [
                Text(
                  widget.recipe.name,
                  style: Theme.of(context).textTheme.bodyLarge
                ),
                const SizedBox(width: 15,),
                IconButton(
                  onPressed: () {
                    Share.share(widget.recipe.generateShareText());
                  },
                  icon: const Icon(Icons.share, color: Color(0xFF412402))
                ),
                IconButton(
                  onPressed: _editRecipe,
                  icon: const Icon(Icons.edit, color: Color(0xFF412402))
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Color(0xFF412402))
                )
              ],
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

  void _editRecipe() {
    final _nameController = TextEditingController(text: widget.recipe.name); // Name field.
    final _descriptionController = TextEditingController(text: widget.recipe.description); // Description field.
    final _ingredientsController = TextEditingController(text: widget.recipe.getIngredientsTextField()); // Ingredients field.
    final _productsController = TextEditingController(text: widget.recipe.getProductsTextField()); // Products field.

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crear receta', style: Theme.of(context).textTheme.headlineMedium),
          backgroundColor: const Color(0xFFC4BA95),
          content: SingleChildScrollView(
            child: Column( // Fields and indicators.
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nombre', labelStyle: Theme.of(context).textTheme.bodyMedium),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Descripción', labelStyle: Theme.of(context).textTheme.bodyMedium),
                ),
                TextField(
                  controller: _ingredientsController,
                  decoration: InputDecoration(labelText: 'Ingredientes (separados por comas)', labelStyle: Theme.of(context).textTheme.bodyMedium),
                ),
                TextField(
                  controller: _productsController,
                  decoration: InputDecoration(labelText: 'Productos (separados por comas)', labelStyle: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
          actions: [ // Pop-up actions (buttons)
            TextButton( // Button to cancel action and close pop-up.
              child: Text('Cancelar', style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton( // Button to add create recipe, add it to database and close pop-up.
              child: Text('Guardar', style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () {
                final List<String> ingredients = _ingredientsController.text.split(',').map((e) => e.trim()).toList();
                final List<String> products = _productsController.text.split(',').map((e) => e.trim()).toList();

                final recipe = Recipe(
                  id: widget.recipe.id,
                  name: _nameController.text,
                  description: _descriptionController.text,
                  pictures: ['assets/icons/icon_central_perk_logo.png'],
                  ingredients: ingredients,
                  products: products,
                );

                // recipe.copy(id: widget.recipe.id);

                // _addRecipe(recipe);
                _updateRecipe(recipe);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
