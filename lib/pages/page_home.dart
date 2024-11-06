// import 'package:central_perk/models/recipe.dart';
// import 'package:central_perk/models/recipe_manager.dart';
import 'package:central_perk/pages/page_my_barista.dart';
import 'package:central_perk/pages/page_my_recipes.dart';
import 'package:central_perk/pages/page_profile.dart';
// import 'package:central_perk/pages/page_recipe.dart';
import 'package:central_perk/pages/page_search.dart';
import 'package:central_perk/pages/page_shop.dart';
import 'package:central_perk/pages/page_your_opinion.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // static const double spaceBetweenButtons = 15; // Space between footer buttons.
  // static const Color footerBarColor =  Color(0xFFF2E0D3);
  // static const Color appBarColor = Color(0xFF66280a);
  static const Color appBarTextColor = Color(0xFFF2E0D3);

  // final ButtonStyle defaultButton = ElevatedButton.styleFrom( // Footer buttons non-linked to current page.
  //   iconColor: appBarColor,
  //   backgroundColor: footerBarColor
  // );

  // final ButtonStyle selectedButton = ElevatedButton.styleFrom( // Footer button linked to current page.
  //   iconColor: appBarColor,
  //   backgroundColor: const Color(0xFFD1B6A3)
  // );

  void _goToHomePage() {
    setState(() { });
  }

  void _goToSearchPage() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage(title: 'Central Perk - Search page')));
    });
  }

  void _goToShopPage() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopPage(title: 'Central Perk - Shop page')));      
    });
  }

  void _goToProfilePage() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage(title: 'Central Perk - Profile page'))); 
    });
  }

  void _goToPage() {
    setState(() {
      
    });
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
          _getResizeButton()
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
                  children: List.generate(currentSpaceBetweenItems, (index) {
                    return Column(
                      children: [
                        Container(
                          height: 50,
                          color: Colors.amber[600],
                          child: Center(child: Text('Entry $index')),
                        ),
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
