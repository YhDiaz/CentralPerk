import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_manager.dart';
import 'package:central_perk/pages/page_search.dart';
import 'package:central_perk/pages/page_shop.dart';
import 'package:flutter/material.dart';

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

  final int friends = 5;
  final int myRecipes = 2;
  final int likes = 9;
  final double rating = 4.8;

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
            const Text('Ross Geller'),
            const SizedBox(height: 5,),
            const Text('@professorgeller'),
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
                maxHeight: 400,
              ),
              child: CarouselView(
                scrollDirection: Axis.vertical,
                itemExtent: 100,
                shrinkExtent: 0.0,
                children: List<Widget>.generate(5, (int index) {
                  return generateCard(index, RecipeManager.recipes);
                })
              ),
            ),
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
              Icons.people,
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
                  onPressed: () => {},
                  icon: const Icon(Icons.person)
                )
              )
            ],
          )
        ],
      ),
    );
  }
}
