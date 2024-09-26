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
        backgroundColor: appBarColor,
        title: Text(widget.title, style: const TextStyle(color: appBarTextColor)),
      ),
      persistentFooterButtons: 
      [
        ColoredBox
        (
          color: footerBarColor,
          child: Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              ElevatedButton(onPressed: _goToHomePage, style: defaultButton, child: const Icon(Icons.home_outlined)), //Home button
              const SizedBox(width: spaceBetweenButtons),
              ElevatedButton(onPressed: _goToSearchPage, style: defaultButton, child: const Icon(Icons.search_outlined)), //Search button
              const SizedBox(width: spaceBetweenButtons),
              ElevatedButton(onPressed: _goToShopPage, style: selectedButton, child: const Icon(Icons.shop)), //Shop button
              const SizedBox(width: spaceBetweenButtons),
              ElevatedButton(onPressed: _goToProfilePage, style: defaultButton, child: const Icon(Icons.person_outline)), //Profile button
            ],
          )
        )
      ],
    );
  }
}