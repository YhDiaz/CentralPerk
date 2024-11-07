import 'package:central_perk/models/recipe.dart';
import 'package:flutter/material.dart';

class MyBaristaPage extends StatefulWidget {
  const MyBaristaPage({super.key, required this.title});
  final String title;

  @override
  State<MyBaristaPage> createState() => _MyBaristaPageState();
}

class _MyBaristaPageState extends State<MyBaristaPage> {
  static const Color appBarTextColor = Color(0xFFF2E0D3);

  Future<List<Recipe>>? _recipesFuture;
  List<Recipe> _recipes = [];

  @override
  void initState() {
    super.initState();
    print("en el init state del barista");
    _loadRecipes();
    _recipes = _buildMyBaristaRecipesList();
  }

  Future<void> _loadRecipes() async {
    setState(() {
      _recipesFuture = Recipe.loadMyBaristaRecipes();
    });
  }

  List<Recipe> _buildMyBaristaRecipesList() {
    if (_recipesFuture == null) {
      return []; // Or show an empty list message
    }
    _recipesFuture!.then((result) {
      for (var item in result) {
        _recipes.add(item);
      }
    });
    return _recipes;
  }

  @override
  Widget build(BuildContext context) {
    print("players es: ${_recipes.toList()}");

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<Recipe>>(
        future: _recipesFuture, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
          Widget expanded = Column(
            children: [
              Expanded( // To avoid problems due to include a ListView inside a Column.
                child: SizedBox(
                  width: 350.0, // Width of list items.
                  child: ListView.builder(
                    itemCount: _recipes.length,
                    itemBuilder: (context, index) {
                      // return _recipes[index].getCard(context);
                      return Text('no recipe $index');
                    },
                  )
                ),
              )
            ],
          );
          if (snapshot.hasData) {
            expanded = Column(
              children: [
                Expanded( // To avoid problems due to include a ListView inside a Column.
                  child: SizedBox(
                    width: 350.0, // Width of list items.
                    child: ListView.builder(
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        return _recipes[index].getCard(context);
                        // return Text('recipe has data $index');
                      },
                    )
                  ),
                )
              ],
            );
          }
          else if (snapshot.hasError) {
            expanded = Column(
              children: [
                Expanded( // To avoid problems due to include a ListView inside a Column.
                  child: SizedBox(
                    width: 350.0, // Width of list items.
                    child: ListView.builder(
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        // return _recipes[index].getCard(context);
                        return Text('recipe has error $index');
                      },
                    )
                  ),
                )
              ],
            );
          } else {
            expanded = Column(
              children: [
                Expanded( // To avoid problems due to include a ListView inside a Column.
                  child: SizedBox(
                    width: 350.0, // Width of list items.
                    child: ListView.builder(
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        // return _recipes[index].getCard(context);
                        return Text('');
                      },
                    )
                  ),
                )
              ],
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title, style: const TextStyle(color: appBarTextColor)),
            ),
            body: expanded
            
          );
        },
      ),
    );
  }
}
