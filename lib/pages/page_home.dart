import 'package:central_perk/pages/page_my_barista.dart';
import 'package:central_perk/pages/page_my_recipes.dart';
import 'package:central_perk/pages/page_recipe.dart';
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

  void _goToHomePage() {
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: appBarColor,
        title: Text(widget.title, style: const TextStyle(color: appBarTextColor)),
      ),
      body: Center(
        child: _getBody()
      ),
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
          // _getResizeButton()
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
  
  final List<Map<String, String>> recetas = [ 
    {
      'name': 'Café Latte',
      'description': 'Una deliciosa combinación de café expreso y leche vaporizada.',
      'image': 'assets/icons/icon_coffee_american.jpg',
    },
    {
      'name': 'Capuchino',
      'description': 'Café expreso, leche vaporizada y espuma de leche.',
      'image': 'assets/icons/icon_coffee_latte.jpg',
    }, // Agrega más recetas aquí
  ];

  // Get activity in recipes to display in home page, depending my recipes list is empty or not.
  Widget _getActivityInfo(bool myRecipesEmpty) {
    return myRecipesEmpty ?
            const Text('No hay recetas en la lista') : // No recipes to display.
            Expanded( // To avoid problems due to include a ListView inside a Column.
              child: SizedBox(
                width: 350.0, // Width of list items.
                child: ListView( // Recipes are displayed as a list.
                  padding: const EdgeInsets.all(8),
                  // REPLACE 2 WHEN IMPLEMENT DATA BASE
                  children: List.generate(/*currentSpaceBetweenItems*/2, (index) {
                    return Column(
                      children: [
                        Card(
                          color: const Color(0xFFE0D0C0), // Card color.
                          elevation: 8,
                          margin: EdgeInsets.symmetric(vertical: 10), // Vertical margin.
                          child: InkWell( // To detect taps.
                            onTap: () { // Behavior when touch the recipe.
                              Navigator.push( // Add Recipe page to navigation stack.
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipePage(title: 'Receta'),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center( // Center image.
                                  child: ClipRRect( // Add recipe image with rounded borders.
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)), // Top card border.
                                    child: Image.asset(
                                      recetas[index]['image']!,
                                      width: 350,
                                      height: 250,
                                      fit: BoxFit.cover, // To adjust image to container.
                                    ),
                                  ),
                                ),
                                Padding( // Recipe name.
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    recetas[index]['name']!,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding( // Recipe content.
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    recetas[index]['description']!,
                                    style: TextStyle(fontSize: 16, color: const Color(0xFF674722)),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 50,
                        //   color: Colors.amber[600],
                        //   child: Center(child: Text('Entry $index')),
                        // ),
                        _getSpace('content_content')
                      ],
                    );
                  })
                )
              ),
            );
  }
  
  Widget _getDrawer(BuildContext context) {
    return Drawer(
      child: ListView( // In case there isn't enough space for all options.
        padding: EdgeInsets.zero, // Recommended by Flutter documentation.
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Central Perk - Navegación'),
          ),
          ListTile(
            title: const Text('Principal'),
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
              );
            },
          ),
          ListTile(
            title: const Text('Mi barista'),
            onTap: () {
              Navigator.pop(context); // Close drawer before go to another page.
              Navigator.push( // Go to My barista page.
                context,
                MaterialPageRoute(builder: (context) => const MyBaristaPage())
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
}
