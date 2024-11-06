import 'package:central_perk/pages/page_create_recipe.dart';
import 'package:flutter/material.dart';

class MyRecipesPage extends StatefulWidget {
  const MyRecipesPage({super.key, required this.title});
  final String title;

  @override
  State<MyRecipesPage> createState() => _MyRecipesPageState();
}

class _MyRecipesPageState extends State<MyRecipesPage> {
  // static const double spaceBetweenButtons = 15; //Space between footer buttons
  static const Color footerBarColor =  Color(0xFFF2E0D3);
  static const Color appBarColor = Color(0xFF66280a);
  static const Color appBarTextColor = Color(0xFFF2E0D3);

  final ButtonStyle defaultButton = ElevatedButton.styleFrom //Footer buttons non-linked to current page
  (
    iconColor: appBarColor,
    backgroundColor: footerBarColor
  );

  final ButtonStyle selectedButton = ElevatedButton.styleFrom //Footer button linked to current page
  (
    iconColor: appBarColor,
    backgroundColor: const Color(0xFFD1B6A3)
  );

  // bool _isAddButton = true;

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
      // drawer: _getDrawer(context)
      floatingActionButton: _getFloatingActionButton()

    );
  }

  // Get body.
  Widget _getBody() {
    return Center(
      child: Column(       
        children: <Widget>[
          _getSpace('header_content'),
          _getActivityInfo(false), // Activity in recipes to display in home page.
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

  Widget _getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push( // Go to Create recipe page.
          context,
          MaterialPageRoute(builder: (context) => const CreateRecipePage())
        );
      },
      child: const Icon(Icons.add)
    );
    // return _isAddButton ?
    //         FloatingActionButton(
    //           onPressed: () {
    //             setState(() {
    //               _isAddButton = false;
    //             });
    //           },
    //           child: const Icon(Icons.add)
    //         ) :
    //         FloatingActionButton(
    //           onPressed: () {
    //             setState(() {
    //               _isAddButton = true;
    //             });
    //           },
    //           child: const Icon(Icons.cancel_outlined)
    //         );
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
              // Navigator.push( // Go to My recipes page.
              //   context,
              //   MaterialPageRoute(builder: (context) => const ProfilePage(title: 'Mis recetas'))
              // );
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

  Widget _getAddButton() {
    return FloatingActionButton(
      heroTag: 'tag1',
      onPressed: () {
        //OPEN POP UP
        setState(() {
          //
          // _getCancelButton();
        });
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _getCancelButton() {
    return FloatingActionButton(
      heroTag: 'tag2',
      onPressed: () {
        // CLOSE POP UP
        setState(() {
          _getAddButton();
        });
      },
      child: const Icon(Icons.cancel),
    );
  }
}
