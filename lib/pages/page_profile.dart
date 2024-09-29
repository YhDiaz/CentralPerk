import 'package:central_perk/models/user_manager.dart';
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
            // Image.asset(
            //   'assets/icons/icon_central_perk_logo.png',
            //   scale: 50,
            // )
            const SizedBox(height: 10,),
            const Icon( // Profile image.
              Icons.person,
              size: 75,
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column( // Friends counter.
                  children: [
                    const Icon(
                      Icons.people,
                      color: Colors.blue,
                      semanticLabel: 'Friends',
                    ),
                    // const Text('Friends'),
                    Text('$friends')
                  ],
                ),
                Column( // Recipes created.
                  children: [
                    // const Text('Recipes created'),
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
                    // const Text('Likes received'),
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
                    // const Text('Average rating'),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      semanticLabel: 'Average rating',
                    ),
                    Text('$rating')
                  ],
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
}