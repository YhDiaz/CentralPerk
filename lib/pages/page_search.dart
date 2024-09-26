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
              ElevatedButton(onPressed: _goToSearchPage, style: selectedButton, child: const Icon(Icons.search)), //Search button
              const SizedBox(width: spaceBetweenButtons),
              ElevatedButton(onPressed: _goToShopPage, style: defaultButton, child: const Icon(Icons.shop_outlined)), //Shop button
              const SizedBox(width: spaceBetweenButtons),
              ElevatedButton(onPressed: _goToProfilePage, style: defaultButton, child: const Icon(Icons.person_outline)), //Profile button
            ],
          )
        )
      ],
    );
  }
}