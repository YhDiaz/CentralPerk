
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
              style: Theme.of(context).textTheme.headlineLarge
            ),
            const SizedBox(width: 56,),
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
      drawer: _getDrawer(context),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _showSelectionDialog(context);
      //   },
      //   child: Icon(Icons.camera_alt),
      // ),
    );
  }

  // Future<void> _showSelectionDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //             title: Text("From where do you want to take the photo?"),
  //             content: SingleChildScrollView(
  //               child: ListBody(
  //                 children: <Widget>[
  //                   GestureDetector(
  //                     child: Text("Gallery"),
  //                     onTap: () {
  //                       _openGallery(context);
  //                     },
  //                   ),
  //                   Padding(padding: EdgeInsets.all(8.0)),
  //                   GestureDetector(
  //                     child: Text("Camera"),
  //                     onTap: () {
  //                       _openCamera(context);
  //                     },
  //                   )
  //                 ],
  //               ),
  //             ));
  //       });
  // }
  // String imagePath = '';

  // Future<void> _openGallery(BuildContext context) async {
  //   XFile? picture = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (picture == null) return;

  //   File tmpFile = File(picture.path);
  //   // getting a directory path for saving
  //   final Directory d = await getApplicationDocumentsDirectory();
  //   final String path = d.path;

  //   setState(() {
  //   imagePath = '$path/image${DateTime.now()}.png';

      
  //   });

  //   // copy the file to a new path
  //   await tmpFile.copy(imagePath);

  //   Navigator.of(context).pop();
  // }

  // void _openCamera(BuildContext context) async {
  //   XFile? picture = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (picture == null) return;

  //   File tmpFile = File(picture.path);
  //   // getting a directory path for saving
  //   final Directory d = await getApplicationDocumentsDirectory();
  //   final String path = d.path;

  //   setState(() {
  //   imagePath = '$path/image${DateTime.now()}.png';

      
  //   });

  //   // copy the file to a new path
  //   await tmpFile.copy(imagePath);

  //   Navigator.of(context).pop();
  // }

  // Get body.
  Widget _getBody() {
    return Center(
      child: Column(       
        children: <Widget>[
          _getSpace('appbar_header'),
          _generateSectionTitle('Actividad reciente'), // Generate custom title for section.
          _getSpace('header_content'),
          _getActivityInfo(), // Activity in recipes to display in home page.
          _getSpace('content_content'),
          // _setImageView(),
          // (imagePath != '') ?
          //   Image.file(File(imagePath))
          // :
          //   Text('')
        ],
      )
    );
  }

  // Generate custom title for section.
  Widget _generateSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium
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
        const SizedBox( // type == 'content_content'.
          height: 10,
        );
  }

  // Get activity in recipes to display in home page, depending my recipes list is empty or not.
  Widget _getActivityInfo() {
    return recipes.length == 0 ?
            Container(
              width: 300,
              child: Text( // No recipes to display.
                'No hay recetas en la lista. Agregue desde Mis recetas o Mi barista.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          :
            Text('');
            // Column(
            //   children: List.generate(recipes.length, (index) {
            //     return recipes[index].getCard(context, (recipe) {}, _loadRecipes);
            //   })
              // children: recipes.map((receta) => receta.getCard(context, (recipe) {}, _loadRecipes)).toList(),
              // children: List.generate(2, (index) {

              // }),
            // );
            // Expanded( // To avoid problems due to include a ListView inside a Column.
            //   child: SizedBox(
            //     width: 350.0, // Width of list items.
            //     child: ListView( // Recipes are displayed as a list.
            //       padding: const EdgeInsets.all(8),
            //       children: recipes.map((receta) => receta.getCard(context, (recipe) {}, _loadRecipes)).toList()
            //     )
            //   ),
            // );
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
            title: Text('Principal', style: Theme.of(context).textTheme.headlineMedium),
            selected: true,
            onTap: () {
              Navigator.pop(context); // Close the drawer.
            },
          ),
          ListTile(
            title: Text('Mis recetas', style: Theme.of(context).textTheme.headlineMedium),
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
            title: Text('Mi barista', style: Theme.of(context).textTheme.headlineMedium),
            onTap: () {
              Navigator.pop(context); // Close drawer before go to another page.
              Navigator.push( // Go to My barista page.
                context,
                MaterialPageRoute(builder: (context) => const MyBaristaPage(title: 'Mi barista',))
              ).then((_) {
                _loadRecipes();
              });
            },
          ),
          ListTile(
            title: Text('Tu opinión', style: Theme.of(context).textTheme.headlineMedium),
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


  // Display pop-up to confirm the user want to delete their recipes.
  void _displayCleanDatabaseAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFC4BA95),
          title: Text( // Pop-up title.
            'Eliminar recetas',
            style: Theme.of(context).textTheme.headlineMedium
          ),
          content: Text( // Alert message.
            '¿Quieres continuar con la eliminación de tus recetas?',
            style: Theme.of(context).textTheme.bodyMedium
          ),
          actions: [
            TextButton( // Button to cancel action and close pop-up.
              child: Text('Cancelar', style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton( // Button to eliminate recipes and close pop-up.
              child: Text('Eliminar', style: Theme.of(context).textTheme.bodyMedium),
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
