import 'package:central_perk/pages/page_profile.dart';
import 'package:central_perk/pages/page_search.dart';
import 'package:central_perk/pages/page_shop.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  int _counter = 0;
  static const double spaceBetweenButtons = 15; //Space between footer buttons

  void _incrementCounter()
  {
    setState(()
    {
      _counter++;
    });
  }

  void _goToHomePage()
  {
    setState(()
    {
      
    });
  }

  void _goToSearchPage()
  {
    setState(()
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage(title: 'Central Perk - Search page')));
    });
  }

  void _goToShopPage()
  {
    setState(()
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopPage(title: 'Central Perk - Shop page')));      
    });
  }

  void _goToProfilePage()
  {
    setState(()
    {
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
      body: Center
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>
          [
            const Text
            (
              'You have pushed the button this many times:',
            ),
            Text
            (
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      persistentFooterButtons: 
      [
        Row
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            ElevatedButton(onPressed: _goToHomePage, child: const Icon(Icons.home)), //Home button
            const SizedBox(width: spaceBetweenButtons),
            ElevatedButton(onPressed: _goToSearchPage, child: const Icon(Icons.search_outlined)), //Search button
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
