import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_manager.dart';
import 'package:central_perk/pages/page_profile.dart';
import 'package:central_perk/pages/page_search.dart';
import 'package:central_perk/pages/page_shop.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(widget.title, style: const TextStyle(color: appBarTextColor)),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 350, maxWidth: 400),
          child: CarouselView(
            scrollDirection: Axis.vertical,
            itemExtent: 100,
            children: List<Widget>.generate(5, (int index) {
              return generateCard(index, RecipeManager.recipes);
            })
          ),
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
                style: selectedButton,
                child: const Icon(Icons.home)
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
                style: defaultButton,
                child: const Icon(Icons.person_outline)
              ),
            ],
          ),
        )
      ],
    );
  }
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
            SizedBox.square(dimension: 50, child: IconButton(onPressed: () => {}, icon: const Icon(Icons.person)))
          ],
        )
      ],
    ),
  );
}
