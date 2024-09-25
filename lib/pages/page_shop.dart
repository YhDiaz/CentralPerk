import 'package:central_perk/pages/page_search.dart';
import 'package:central_perk/pages/page_profile.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget
{
  const ShopPage({super.key, required this.title});
  final String title;

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
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
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage(title: 'Central Perk - Search page')));  
    });
  }

  void _goToShopPage()
  {
    setState(()
    {
          
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
            ElevatedButton(onPressed: _goToSearchPage, child: const Icon(Icons.search_outlined)), //Search button
            const SizedBox(width: spaceBetweenButtons),
            ElevatedButton(onPressed: _goToShopPage, child: const Icon(Icons.shop)), //Shop button
            const SizedBox(width: spaceBetweenButtons),
            ElevatedButton(onPressed: _goToProfilePage, child: const Icon(Icons.person_outline)), //Profile button
          ],
        )
      ],
    );
  }
}