import 'package:central_perk/models/recipe_database.dart';
import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/pages/page_my_barista.dart';
import 'package:central_perk/pages/page_my_recipes.dart';
import 'package:central_perk/pages/page_your_opinion.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color appBarTextColor = Color(0xFFF2E0D3);

  List<Recipe> recipes = [];

  @override void initState() {
    super.initState();
    _loadRecipes();
  }
  
  Future<void> _loadRecipes() async {
    final dbRecipes = RecipeDatabase.instance;
    final _recipes = await dbRecipes.readAllRecipes();
    setState(() {
      recipes = _recipes;
    });
  }

  Future<void> _clearDatabase() async {
    final dbRecipes = RecipeDatabase.instance;
    await dbRecipes.clearDatabase();
    _loadRecipes();
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(width: 77,),
            IconButton(
              onPressed: _displayCleanDatabaseAlert,
              icon: const Icon(Icons.cleaning_services_outlined)
            ),
            const SizedBox(width: 5,),
            Image.asset(
              'assets/icons/icon_central_perk_logo.png',
              fit: BoxFit.contain,
              height: 75,
            ),
          ],
        ),
      ),
      body: _getBody(),
      drawer: _getDrawer(context)
    );
  }

  // Get body.
  Widget _getBody() {
    return Center(
      child: Column(       
        children: <Widget>[
          _getSpace('appbar_header'),
          _generateSectionTitle('Actividad reciente'), // Generate custom title for section.
          _getSpace('header_content'),
          _getActivityInfo(false), // Activity in recipes to display in home page.
          _getSpace('content_content'),
        ],
      )
    );
  }

  // Generate custom title for section.
  Widget _generateSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 25
      ),
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
        SizedBox( // type == 'content_content'.
          height: currentSpaceBetweenItems.toDouble(),
        );
  }

  // Get activity in recipes to display in home page, depending my recipes list is empty or not.
  Widget _getActivityInfo(bool myRecipesEmpty) {
    return myRecipesEmpty ?
            const Text('No hay recetas en la lista') : // No recipes to display.
            Expanded( // To avoid problems due to include a ListView inside a Column.
              child: SizedBox(
                width: 350.0, // Width of list items.
                child: ListView( // Recipes are displayed as a list.
                  padding: const EdgeInsets.all(8),
                  children: recipes.map((receta) => receta.getCard(context, (recipe) {})).toList()
                )
              ),
            );
  }
  
  Widget _getDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFDECEB2),
      child: ListView( // In case there isn't enough space for all options.
        padding: EdgeInsets.zero, // Recommended by Flutter documentation.
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/icon_central_perk_logo.png')
              ),
              color: Color(0xFFDECEB2),
            ),
            child: Text(''),
          ),
          ListTile(
            title: Text('Principal', style: Theme.of(context).textTheme.bodyLarge,),
            selected: true,
            onTap: () {
              Navigator.pop(context); // Close the drawer.
            },
          ),
          ListTile(
            title: const Text('Mis recetas'),
            onTap: () {
              Navigator.pop(context); // Close drawer before go to another page.
              Navigator.push( // Go to My recipes page.
                context,
                MaterialPageRoute(builder: (context) => const MyRecipesPage(title: 'Mis recetas'))
              ).then((_) {
                _loadRecipes();
              });
            },
          ),
          ListTile(
            title: const Text('Mi barista'),
            onTap: () {
              Navigator.pop(context); // Close drawer before go to another page.
              Navigator.push( // Go to My barista page.
                context,
                MaterialPageRoute(builder: (context) => const MyBaristaPage(title: 'Mi barista',))
              );
            },
          ),
          ListTile(
            title: const Text('Tu opinión'),
            onTap: () {
              Navigator.pop(context); // Close drawer before go to another page.
              Navigator.push( // Go to Your opinion page.
                context,
                MaterialPageRoute(builder: (context) => const YourOpinionPage())
              );
            },
          ),
        ],
      ),
    );
  }

  List<int> spaceBetweenItems = <int>[0, 3, 5, 7, 10, 13];
  int currentSpaceBetweenItems = 0;

  Widget _getResizeButton() {
    return FloatingActionButton(
      onPressed: _getNextSize,
      child: Text('$currentSpaceBetweenItems')
    );
  }

  int _getNextSize() {
    if (currentSpaceBetweenItems == -1 || currentSpaceBetweenItems == spaceBetweenItems.last) {
      setState(() {
        currentSpaceBetweenItems = spaceBetweenItems[0];
      });      
      return spaceBetweenItems[0];
    }

    for (int i = 0; i < spaceBetweenItems.length; i++) {
      if (spaceBetweenItems[i] == currentSpaceBetweenItems) {
        setState(() {
          currentSpaceBetweenItems = spaceBetweenItems[i + 1];
        });        
        return spaceBetweenItems[i + 1];
      }
    }

    return -1;
  }

  // Display pop-up to confirm the user want to delete their recipes.
  void _displayCleanDatabaseAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar recetas'), // Pop-up title.
          content: const Text('¿Quieres continuar con la eliminación de tus recetas?'), // Alert message.
          actions: [
            TextButton( // Button to cancel action and close pop-up.
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton( // Button to eliminate recipes and close pop-up.
              child: const Text('Eliminar'),
              onPressed: () {
                Navigator.of(context).pop();
                _clearDatabase();
              },
            ),
          ],
        );
      },
    );
  }
}
