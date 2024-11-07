import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_database.dart';
// import 'package:central_perk/pages/page_create_recipe.dart';
import 'package:flutter/material.dart';

class MyRecipesPage extends StatefulWidget {
  const MyRecipesPage({super.key, required this.title});
  final String title;

  @override
  State<MyRecipesPage> createState() => _MyRecipesPageState();
}

class _MyRecipesPageState extends State<MyRecipesPage> {
  static const Color appBarTextColor = Color(0xFFF2E0D3);

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
        title: Text(widget.title, style: const TextStyle(color: appBarTextColor)),
      ),
      body: Center(
        child: _getBody()
      ),
      floatingActionButton: _getFloatingActionButton()

    );
  }

  // Display pop-up to create a recipe.
  void _addRecipeTab() {
    // Fields to write a text.
    final _nameController = TextEditingController(); // Name field.
    final _descriptionController = TextEditingController(); // Description field.
    final _imageController = TextEditingController(); // Image field.
    // Hay que hacer que la imagen se pueda seleccionar, por ahora hay que pasar la ruta en el directorio de íconos

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crear receta'),
          content: Column( // Fields and indicators.
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Imagen principal'),
              ),
            ],
          ),
          actions: [ // Pop-up actions (buttons)
            TextButton( // Button to cancel action and close pop-up.
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton( // Button to add create recipe, add it to database and close pop-up.
              child: Text('Agregar'),
              onPressed: () {
                final recipe = Recipe(
                  name: _nameController.text,
                  description: _descriptionController.text,
                  image: _imageController.text,
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
        SizedBox(
          height: currentSpaceBetweenItems.toDouble(),
        );
  }

  // Get activity in recipes to display in home page, depending my recipes list is empty or not.
  Widget _getActivityInfo() {
    return recipes.length == 0 ?
            SizedBox(
              width: 300.0,
              child: const Text('Aún no has creado ninguna receta. Presiona + para agregar una o edita una receta de Mi barista para que se muestre aquí.'),
            ) :
            Expanded( // To avoid problems due to include a ListView inside a Column.
              child: SizedBox(
                width: 350.0, // Width of list items.
                child: ListView( // Recipes are displayed as a list.
                  padding: const EdgeInsets.all(8),
                  children: recipes.map((receta) => receta.getCard(context)).toList()
                )
              ),
            );
  }

  Widget _getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _addRecipeTab,
      child: const Icon(Icons.add)
    );
  }

  List<int> spaceBetweenItems = <int>[0, 3, 5, 7, 10, 13];
  int currentSpaceBetweenItems = 0;
}
