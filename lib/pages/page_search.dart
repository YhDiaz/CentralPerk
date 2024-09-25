import 'package:central_perk/pages/page_shop.dart';
import 'package:central_perk/pages/page_profile.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget
{
  const SearchPage({super.key, required this.title});
  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
{
  static const double spaceBetweenButtons = 15; //Space between footer buttons

  void _goToHomePage()
  {
    setState(()
    {
      Navigator.pop(context); 
    });
  }

  void _goToSearchPage()
  {
    setState(()
    {

    });
  }

  void _goToShopPage()
  {
    setState(()
    {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopPage(title: 'Central Perk - Shop page')));
    });
  }

  void _goToProfilePage()
  {
    setState(()
    {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage(title: 'Central Perk - Profile page'))); 
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      persistentFooterButtons: 
      [
        Row
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            ElevatedButton(onPressed: _goToHomePage, child: const Icon(Icons.home_outlined)), //Home button
            const SizedBox(width: spaceBetweenButtons),
            ElevatedButton(onPressed: _goToSearchPage, child: const Icon(Icons.search)), //Search button
            const SizedBox(width: spaceBetweenButtons),
            ElevatedButton(onPressed: _goToShopPage, child: const Icon(Icons.shop_outlined)), //Shop button
            const SizedBox(width: spaceBetweenButtons),
            ElevatedButton(onPressed: _goToProfilePage, child: const Icon(Icons.person_outline)), //Profile button
          ],
        )
      ],
    );
  }
}