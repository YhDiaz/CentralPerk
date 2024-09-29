import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_manager.dart';
import 'package:central_perk/pages/page_shop.dart';
import 'package:central_perk/pages/page_profile.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});
  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
{
  static const double spaceBetweenButtons = 15; //Space between footer buttons
  static const Color footerBarColor =  Color(0xFFF2E0D3);
  static const Color appBarColor = Color(0xFF66280a);
  static const Color appBarTextColor = Color(0xFFF2E0D3);

  // Footer buttons non-linked to current page.
  final ButtonStyle defaultButton = ElevatedButton.styleFrom(
    iconColor: appBarColor,
    backgroundColor: footerBarColor
  );

  // Footer button linked to current page.
  final ButtonStyle selectedButton = ElevatedButton.styleFrom(
    iconColor: appBarColor,
    backgroundColor: const Color(0xFFD1B6A3)
  );

  void _goToHomePage() {
    setState(() {
      Navigator.pop(context); 
    });
  }

  void _goToSearchPage() {
    setState(() { });
  }

  void _goToShopPage() {
    setState(() {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopPage(title: 'Central Perk - Shop page')));
    });
  }

  void _goToProfilePage() {
    setState(() {
      Navigator.pop(context);
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
        child: Column(
          children: [
            const SizedBox(height: 10,),
            const SearchBar(
              hintText: 'Search...',
              backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 193, 155, 112)),
              leading: Icon(Icons.search),
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 25)),
            ),
            const SizedBox(height: 10,),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 50,
                maxHeight: 60,
              ),
              child: CarouselView(
                itemExtent: 150,
                shrinkExtent: 0.0,
                children: List<Widget>.generate(20, (int index) {
                  return Card(
                    margin: const EdgeInsets.all(7.5),
                    color: const Color.fromARGB(255, 173, 150, 131),
                    child: MaterialButton(
                      onPressed: () => {},
                      enableFeedback: false,
                      child: Row(
                        children: [
                          const Icon(Icons.tag),
                          const SizedBox(width: 10,),
                          Text('Tag ${index + 1}'),
                        ],
                      ),
                    )
                  );
                }),
              ),
            ),
            const SizedBox(height: 20,),
            ConstrainedBox(
              constraints: const BoxConstraints( // Scroll box size.
                minHeight: 350,
                maxHeight: 525,
              ),
              child: CarouselView(
                scrollDirection: Axis.vertical,
                itemExtent: 125, // Item size (in this case, height).
                shrinkExtent: 0.0,
                children: List<Widget>.generate(5, (int index) {
                  return generateCard(index, RecipeManager.recipes);
                }),
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
                style: selectedButton,
                child: const Icon(Icons.search)
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
          )
        )
      ],
    );
  }
}

Widget generateCard(int index, List<Recipe> recipes) {
  return Card(
    margin: const EdgeInsets.all(7.5),
    color: const Color.fromARGB(255, 173, 150, 131),
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
        const SizedBox(width: 75,), // Space between info and user.
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox.square(dimension: 50, child: IconButton(onPressed: () => {}, icon: const Icon(Icons.person)))
          ],
        )
      ]
    )
  );
}
