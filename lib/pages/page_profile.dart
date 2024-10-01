import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_manager.dart';
import 'package:central_perk/models/user.dart';
import 'package:central_perk/models/user_manager.dart';
import 'package:central_perk/pages/page_recipe.dart';
import 'package:central_perk/pages/page_search.dart';
import 'package:central_perk/pages/page_shop.dart';
import 'package:flutter/material.dart';

User myUser = UserManager.users[0];

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});
  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const double spaceBetweenButtons = 15; //Space between footer buttons
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

  final String name = myUser.name;
  final String username = myUser.username;
  final int friends = myUser.friendsCount();
  final int myRecipes = myUser.recipesCount();
  final int likes = myUser.likesCount();
  final double rating = myUser.averageRating();

  void _goToHomePage() {
    setState(() {
      Navigator.pop(context);
    });
  }

  void _goToSearchPage() {
    setState(() {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage(title: 'Central Perk - Search page')));
    });
  }

  void _goToShopPage() {
    setState(() {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopPage(title: 'Central Perk - Shop page')));      
    });
  }

  void _goToProfilePage() {
    setState(() { });
  }

  void _favoriteOnPressed(Recipe recipe) {
    setState(() {
      if (recipe.favorite) {
        myUser.removeFromFav(recipe);
        const Icon(Icons.favorite_border_outlined);
      } else {
        myUser.markRecipeAsFav(recipe);
        const Icon(Icons.favorite);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          widget.title,
          style: const TextStyle(color: appBarTextColor)
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            const Icon( // Profile image.
              Icons.person,
              size: 75,
            ),
            const SizedBox(height: 5,),
            Text(name),
            const SizedBox(height: 5,),
            Text(username),
            const SizedBox(height: 10,),
            profileInfo(), // Friends, recipes, likes and rating.
            const SizedBox(height: 20,),
            const Row( // My recipes header.
              children: [
                Padding(padding: EdgeInsets.only(left: 10)),
                Text(
                  'My recipes',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            ConstrainedBox(
              constraints: const BoxConstraints( // Scroll box size.
                minHeight: 350,
                maxHeight: 375,
              ),
              child: CarouselView(
                scrollDirection: Axis.vertical,
                itemExtent: 100,
                shrinkExtent: 0.0,
                onTap: (int index) => {
                  setState(() {
                    RecipeManager.displayRecipe = orderedRecipes(myUser.myRecipes)[index];
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RecipePage(title: '')));
                  })
                },
                children: List<Widget>.generate(myRecipes, (int index) {
                  List<Recipe> auxRecipes = orderedRecipes(myUser.myRecipes);
                  return generateCard(index, auxRecipes);
                })
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: FloatingActionButton(
                    onPressed: () => {},
                    backgroundColor: const Color.fromARGB(255, 211, 176, 116),
                    foregroundColor: const Color.fromARGB(255, 73, 50, 3),
                    tooltip: 'Create new recipe',
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        ColoredBox(
          color: footerBarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton( // Home button.
                onPressed: _goToHomePage,
                style: defaultButton,
                child: const Icon(Icons.home_outlined)
              ),
              const SizedBox(width: spaceBetweenButtons),
              FilledButton( // Search button.
                onPressed: _goToSearchPage,
                style: defaultButton,
                child: const Icon(Icons.search_outlined)
              ),
              const SizedBox(width: spaceBetweenButtons),
              FilledButton( // Shop button.
                onPressed: _goToShopPage,
                style: defaultButton,
                child: const Icon(Icons.shop_outlined)
              ),
              const SizedBox(width: spaceBetweenButtons),
              FilledButton( // Profile button.
                onPressed: _goToProfilePage,
                style: selectedButton,
                child: const Icon(Icons.person)
              ),
            ],
          )
        )
      ],
    );
  }

  Row profileInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column( // Friends counter.
          children: [
            const Icon(
              Icons.groups,
              color: Colors.blue,
              semanticLabel: 'Friends',
            ),
            Text('$friends')
          ],
        ),
        Column( // Recipes created.
          children: [
            const Icon(
              Icons.receipt,
              color: Colors.brown,
              semanticLabel: 'Recipes created',
            ),
            Text('$myRecipes')
          ],
        ),
        Column( // Likes received.
          children: [
            const Icon(
              Icons.favorite,
              color: Colors.red,
              semanticLabel: 'Likes received',
            ),
            Text('$likes')
          ],
        ),
        Column( // Average rating.
          children: [
            const Icon(
              Icons.star,
              color: Colors.yellow,
              semanticLabel: 'Average rating',
            ),
            Text('$rating')
          ],
        ),
      ],
    );
  }

  // Return an ordered list of recipes, with favorite recipes at top.
  List<Recipe> orderedRecipes(List<Recipe> recipes) {
    List<Recipe> ordRecipes = List.empty(growable: true);

    // Favorite recipes.
    for (int i = myUser.favoriteRecipes.length - 1; i >= 0; i--) {
      ordRecipes.add(myUser.favoriteRecipes[i]);
    }

    // Normal recipes.
    for (int i = recipes.length - 1; i >= 0; i--) {
      // Current recipe is not favorite.
      if (!myUser.favoriteRecipes.contains(recipes[i])) {
        ordRecipes.add(recipes[i]);
      }
    }

    return ordRecipes;
  }

  Widget generateCard(int index, List<Recipe> recipes) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: const Color.fromARGB(255, 163, 128, 104),
      child: Row(
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          SizedBox( // Recipe image.
            height: 75,
            width: 75,
            child: Image.asset(recipes[index].image)
          ),
          const SizedBox(width: 15,), // Space between recipe image and info.
          Column( // Info: recipe name and publish date.
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(recipes[index].name),
              Row(
                children: [
                  Text(recipes[index].date.day.toString()),
                  const Text('/'),
                  Text(recipes[index].date.month.toString()),
                  const Text('/'),
                  Text(recipes[index].date.year.toString()),
                ],
              ),
            ],
          ),
          const SizedBox(width: 75,), //Space between info and user
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox.square(
                dimension: 50,
                child: IconButton(
                  onPressed: () => {
                    setState(() {
                      _favoriteOnPressed(recipes[index]);
                    })
                  },
                  icon: (recipes[index].favorite) ? // If recipe has been marked as fav
                        const Icon(Icons.favorite) : // Then, its icon is favorite filled
                        const Icon(Icons.favorite_border_outlined) // Otherwise, its icon is favorite bordered.
                )
              )
            ],
          ),
          const SizedBox(width: 10,),
        ],
      ),
    );
  }
}
