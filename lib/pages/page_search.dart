import 'package:central_perk/models/coffe_bean_type.dart';
import 'package:central_perk/models/recipe.dart';
import 'package:central_perk/models/recipe_visibility.dart';
import 'package:central_perk/models/user.dart';
import 'package:central_perk/pages/page_shop.dart';
import 'package:central_perk/pages/page_profile.dart';
import 'package:flutter/material.dart';

List<User> users = [
  User(name: 'CarlosMartínez', password: '', profileImage: ''),
  User(name: 'AnaSofía', password: '', profileImage: ''),
  User(name: 'MaríaFernanda', password: '', profileImage: ''),
  User(name: 'DiegoAlejandro', password: '', profileImage: ''),
  User(name: 'SofíaLucía', password: '', profileImage: '')
];

List<Recipe> recipes = [
  Recipe(
    name: 'Café Espresso',
    date: DateTime(2024, 09, 27),
    owner: users[0],
    time: 5,
    description: 'El espresso es un café concentrado y fuerte, conocido por su sabor intenso y su capa de crema en la superficie. Es la base para muchas otras bebidas de café.',
    image: 'assets/icons/icon_coffee_espresso.jpg',
    visibility: RecipeVisibility.public,
    coffeBean: CoffeBeanType.arabica
  ),
  Recipe(
    name: 'Café Latte',
    date: DateTime(2024, 09, 25),
    owner: users[1],
    time: 10,
    description: 'El café latte combina un espresso con una gran cantidad de leche vaporizada, creando una bebida suave y cremosa. A menudo se sirve con una capa de espuma de leche en la parte superior.',
    image: 'assets/icons/icon_coffee_latte.jpg',
    visibility: RecipeVisibility.public,
    coffeBean: CoffeBeanType.robusta
  ),
  Recipe(
    name: 'Café Mocha',
    date: DateTime(2024, 09, 24),
    owner: users[2],
    time: 10,
    description: 'El café mocha es una deliciosa combinación de espresso, chocolate caliente y leche vaporizada. Es perfecto para aquellos que disfrutan de un toque de dulzura en su café.',
    image: 'assets/icons/icon_coffee_mocha.jpg',
    visibility: RecipeVisibility.public,
    coffeBean: CoffeBeanType.arabica
  ),
  Recipe(
    name: 'Café Americano',
    date: DateTime(2024, 09, 19),
    owner: users[3],
    time: 5,
    description: 'El café americano se prepara diluyendo un espresso con agua caliente, resultando en una bebida más suave y menos concentrada que el espresso, pero con un sabor robusto.',
    image: 'assets/icons/icon_coffee_american.jpg',
    visibility: RecipeVisibility.public,
    coffeBean: CoffeBeanType.arabica
  ),
  Recipe(
    name: 'Café Cappuccino',
    date: DateTime(2024, 08, 31),
    owner: users[4],
    time: 10,
    description: 'El cappuccino es una mezcla equilibrada de espresso, leche vaporizada y espuma de leche. Es conocido por su textura cremosa y su sabor rico.',
    image: 'assets/icons/icon_coffee_cappuccino.jpg',
    visibility: RecipeVisibility.public,
    coffeBean: CoffeBeanType.robusta
  ),
];


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
              constraints: const BoxConstraints(
                minHeight: 350,
                maxHeight: 525,
              ),
              child: CarouselView(
                scrollDirection: Axis.vertical,
                itemExtent: 200,
                shrinkExtent: 0.0,
                children: List<Widget>.generate(5, (int index) {
                  return generateCard(index);
                  // return Card(
                  //   margin: const EdgeInsets.all(7.5),
                  //   color: const Color.fromARGB(255, 173, 150, 131),
                  //   child: Row(
                  //     children: [
                  //       const Padding(padding: EdgeInsets.all(5)),
                  //       SizedBox( // Recipe image.
                  //         height: 75,
                  //         width: 75,
                  //         child: Image.asset(recipes[index].image)
                  //       ),
                  //       const SizedBox(width: 15,), // Space between recipe image and info.
                  //       Column( // Info: recipe name and publish date.
                  //         mainAxisSize: MainAxisSize.min,
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Text(recipes[index].name),
                  //           Row(
                  //             children: [
                  //               Text(recipes[index].date.day.toString()),
                  //               const Text('/'),
                  //               Text(recipes[index].date.month.toString()),
                  //               const Text('/'),
                  //               Text(recipes[index].date.year.toString()),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(width: 75,), //Space between info and user
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  //         children: [
                  //           SizedBox.square(dimension: 50, child: IconButton(onPressed: () => {}, icon: const Icon(Icons.person)))
                  //         ],
                  //       )
                  //     ]
                  //   )
                  // );
                }),
              ),
            ),
            // ConstrainedBox(
            //   constraints: const BoxConstraints(
            //     minWidth: 350, maxWidth: 400
            //   ),
            //   child: CarouselView(
            //     scrollDirection: Axis.vertical,
            //     itemExtent: 150,
            //     shrinkExtent: 0,
            //     children: List<Widget>.generate(5, (int index) {
            //       return Card(
            //         margin: const EdgeInsets.all(8),
            //         color: const Color.fromARGB(255, 163, 128, 104),
            //         child: Row(
            //           children: [
            //             const Padding(padding: EdgeInsets.all(5)),
            //             SizedBox( // Recipe image.
            //               height: 75,
            //               width: 75,
            //               child: Image.asset(recipes[index].image)
            //             ),

            //             const SizedBox(width: 15,), // Space between recipe image and info.
            //             Column( // Info: recipe name and publish date.
            //               mainAxisSize: MainAxisSize.min,
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: <Widget>[
            //                 Text(recipes[index].name),
            //                 Row(
            //                   children: [
            //                     Text(recipes[index].date.day.toString()),
            //                     const Text('/'),
            //                     Text(recipes[index].date.month.toString()),
            //                     const Text('/'),
            //                     Text(recipes[index].date.year.toString()),
            //                   ],
            //                 ),
            //               ],
            //             ),


            //             const SizedBox(width: 75,), //Space between info and user
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 SizedBox.square(dimension: 50, child: IconButton(onPressed: () => {}, icon: const Icon(Icons.person)))
            //               ],
            //             )
            //           ],
            //         ),
            //       );
            //     }),
            //   ),
            // ),
          ],
        ),
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
              FilledButton(onPressed: _goToHomePage, style: defaultButton, child: const Icon(Icons.home_outlined)), //Home button
              const SizedBox(width: spaceBetweenButtons),
              FilledButton(onPressed: _goToSearchPage, style: selectedButton, child: const Icon(Icons.search)), //Search button
              const SizedBox(width: spaceBetweenButtons),
              FilledButton(onPressed: _goToShopPage, style: defaultButton, child: const Icon(Icons.shop_outlined)), //Shop button
              const SizedBox(width: spaceBetweenButtons),
              FilledButton(onPressed: _goToProfilePage, style: defaultButton, child: const Icon(Icons.person_outline)), //Profile button
            ],
          )
        )
      ],
    );
  }
}

Widget generateCard(int index) {
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
        const SizedBox(width: 75,), //Space between info and user
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
