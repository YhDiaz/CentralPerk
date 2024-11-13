import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_database.dart';
import 'package:central_perk/pages/page_my_barista.dart';
import 'package:flutter/material.dart';

class MyRecipesPage extends StatefulWidget {
  const MyRecipesPage({super.key, required this.title});
  final String title;

  @override
  State<MyRecipesPage> createState() => _MyRecipesPageState();
}

class _MyRecipesPageState extends State<MyRecipesPage> {
  List<Recipe> recipes = [];

  @override void initState() {
    super.initState();
    _loadRecipes();
  }
  
  Future<void> _loadRecipes() async {
    final dbHelper = RecipeDatabase.instance;
    final _recipes = await dbHelper.readAllRecipes();
    setState(() {
      recipes = _recipes;
    });
  }

  Future<void> _addRecipe(Recipe recipe) async {
    final dbHelper = RecipeDatabase.instance;
    await dbHelper.createRecipe(recipe);
    _loadRecipes(); // Refresh recipes list.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineLarge
            ),
            const SizedBox(width: 90,),
            Image.asset(
              'assets/icons/icon_central_perk_logo.png',
              fit: BoxFit.contain,
              height: 75,
            ),
          ],
        ),
      ),
      body: Center(
        child: _getBody()
      ),
      floatingActionButton: _getFloatingActionButton()

    );
  }

  // Display pop-up to create a recipe.
  void _addRecipeDialog() {
    // Fields to write text.
    final _nameController = TextEditingController(); // Name field.
    final _descriptionController = TextEditingController(); // Description field.
    final _ingredientsController = TextEditingController(); // Ingredients field.
    final _productsController = TextEditingController(); // Products field.

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
              child: Text('Agregar', style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () {
                final List<String> ingredients = _ingredientsController.text.split(',').map((e) => e.trim()).toList();
                final List<String> products = _productsController.text.split(',').map((e) => e.trim()).toList();

                final recipe = Recipe(
                  name: _nameController.text,
                  description: _descriptionController.text,
                  pictures: ['assets/icons/icon_central_perk_logo.png'],
                  ingredients: ingredients,
                  products: products,
                );

                _addRecipe(recipe);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _createOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar receta', style: Theme.of(context).textTheme.headlineMedium,),
          backgroundColor: const Color(0xFFC4BA95),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                color: const Color(0xFFBDA682),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  title: Text('Crear receta', style: Theme.of(context).textTheme.bodyLarge),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addRecipeDialog();
                  },
                ),
              ),
              Card(
                color: const Color(0xFFBDA682),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  title: Text('Seleccionar receta de Mi barista', style: Theme.of(context).textTheme.bodyLarge),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => MyBaristaPage(title: 'Mi barista'),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar', style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Get body.
  Widget _getBody() {
    return Center(
      child: Column(       
        children: <Widget>[
          _getSpace('header_content'),
          _getActivityInfo(), // Activity in recipes to display in home page.
          _getSpace('content_content'),
        ],
      )
    );
  }

  // Generate vertical space between widgets depending on the type of space.
  Widget _getSpace(String type) {
    return
      type == 'appbar_header' ?
        const SizedBox(
          height: 15,
        ) :
      type == 'header_content' ?
        const SizedBox(
          height: 25,
        ) :
      // type == 'content_content' ?
        const SizedBox(
          height: 10,
        );
  }

  // Get activity in recipes to display in home page, depending my recipes list is empty or not.
  Widget _getActivityInfo() {
    return recipes.length == 0 ?
            SizedBox(
              width: 300.0,
              child: Text(
                'Aún no has creado ninguna receta. Presiona + para agregar una o edita una receta de Mi barista para que se muestre aquí.',
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ) :
            Expanded( // To avoid problems due to include a ListView inside a Column.
              child: SizedBox(
                width: 350.0, // Width of list items.
                child: ListView( // Recipes are displayed as a list.
                  padding: const EdgeInsets.all(8),
                  children: recipes.map((receta) => receta.getCard(context, (recipe) {}, _loadRecipes)).toList()
                )
              ),
            );
  }

  Widget _getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _createOptionsDialog,
      child: const Icon(Icons.add)
    );
  }
}
