import 'package:central_perk/models/coffe_bean_type.dart';
import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_manager.dart';
import 'package:central_perk/models/user_manager.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.title});
  final String title;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
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

  Recipe recipe = RecipeManager.displayRecipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 199, 167, 132),
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          recipe.name, // Recipe page name.
          style: const TextStyle(
            color: appBarTextColor
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container( // Image container with colored borders.
              height: 200,
              width: 250,
              color: Colors.brown,
              child: Center(
                child: Image.asset(recipe.image),
              ),
            ),
            const SizedBox( // Space between image and name.
              height: 20,
              width: 250
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text( // Recipe name.
                recipe.name,
                style: const TextStyle(
                  fontSize: 25
                ),
              ),
            ), // Space between border and name.
            Padding( // Author and button to update friends relationship.
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text('By ${recipe.owner.name} - ${recipe.owner.username}'), // Name and username.
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    child:
                      (UserManager.users[0] == recipe.owner) ?
                        const Text('') : 
                        FilledButton( // Add or remove friend.
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Color.fromARGB(0, 0, 0, 0)) // No background.
                          ),
                          onPressed: () => {
                            setState(() {
                              (UserManager.users[0].friends.contains(recipe.owner)) ? // If button is on pressed and main user and recipe's author are friends,
                                UserManager.users[0].removeFriend(recipe.owner) : // Then, remove friend from each other,
                                UserManager.users[0].addFriend(recipe.owner); // Otherwise, add friend to each other.
                            })
                          },
                          child: Icon(
                            (UserManager.users[0].friends.contains(recipe.owner)) ? // If they are friends,
                              Icons.person_remove : // Then display remove friend icon,
                              Icons.person_add_alt_1, // Otherwise, display add friend icon.
                            color: 
                            (UserManager.users[0].friends.contains(recipe.owner)) ? // They are friends,
                              const Color.fromARGB(255, 202, 23, 23) : // Then, display red icon to remove,
                              const Color.fromARGB(255, 24, 157, 24) // Otherwise, display green icon to add.
                          )
                        ),
                  )
                ],
              ),
            ),
            Row( // General info: recipe name, rating, time and favorite.
              children: [
                const SizedBox(width: 30,),
                Row( // Aditional info.
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column( // Rating and yellow star icon.
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text('${recipe.rating}')
                      ],
                    ),
                    const SizedBox(width: 15,),
                    Column( // Time and gray timer icon.
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Color.fromARGB(255, 100, 100, 100),
                        ),
                        Text('${recipe.time} min')
                      ],
                    ),
                    const SizedBox(width: 15),
                    Column(
                      children: [
                        const Icon(
                          Icons.coffee,
                          color: Color.fromARGB(255, 130, 78, 30),
                        ),
                        Text(CoffeBeanType.values[recipe.coffeBean.index].name)
                      ],
                    ),
                    const SizedBox(width: 15,), // Space between recipe general info and description.
                    FilledButton( // Favorite/save button with red favorite/save icon filled or outlined.
                      onPressed: () => { // Button behavior.
                        setState(() {
                          if (UserManager.users[0] == recipe.owner) {
                            recipe.setFav(!recipe.favorite);
                          } else {
                            if (UserManager.users[0].savedRecipes.contains(recipe)) {
                              UserManager.users[0].savedRecipes.remove(recipe);
                            } else {
                              UserManager.users[0].savedRecipes.add(recipe);
                            }
                          }
                        })
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color.fromARGB(0, 0, 0, 0))
                      ),
                      child: Icon(
                        (recipe.owner == UserManager.users[0]) ?
                          (recipe.favorite) ?
                            Icons.favorite :
                            Icons.favorite_border :
                        (UserManager.users[0].savedRecipes.contains(recipe)) ?
                          Icons.save_rounded :
                          Icons.save_outlined,
                        color: 
                          (recipe.owner == UserManager.users[0]) ?
                          const Color.fromARGB(255, 200, 31, 31) :
                          (UserManager.users[0].savedRecipes.contains(recipe)) ?
                            const Color.fromARGB(255, 24, 157, 24) :
                            const Color.fromARGB(255, 202, 23, 23)
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10,),
            const SizedBox(height: 25,),
            Padding( // Recipe description.
              padding: const EdgeInsets.symmetric(horizontal: 15), // Horizontal margin.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(recipe.description)
                ],
              )
            ),
            const SizedBox(height: 25,),
            Padding( // Recipe ingredients.
              padding: const EdgeInsets.symmetric(horizontal: 15), // Horizontal margin.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(recipe.printIngredients())
                ],
              ),
            ),
            const SizedBox(height: 25,),
            Padding( // Artifacts needed to execute recipe.
              padding: const EdgeInsets.symmetric(horizontal: 15), // Horizontal margin.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Artifacts',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(recipe.printArtifacts())
                ],
              ),
            ),
            const SizedBox(height: 25,),
            Padding( // Steps to execute the recipe.
              padding: const EdgeInsets.symmetric(horizontal: 15), // Horizontal margin.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Steps',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(
                    (recipe.steps == '') ?
                    'It seems like the user forgot to specify the steps...' :
                    recipe.steps
                  )
                ],
              ),
            ),
            const SizedBox(height: 25,),
            Padding( // Recipe comments.
              padding: const EdgeInsets.symmetric(horizontal: 15), // Horizontal margin.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(recipe.printComments())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}