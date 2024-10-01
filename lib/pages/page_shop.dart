import 'package:central_perk/models/product.dart';
import 'package:central_perk/models/user_manager.dart';
import 'package:central_perk/pages/page_search.dart';
import 'package:central_perk/pages/page_profile.dart';
import 'package:flutter/material.dart';

List<Product> products = [
  Product(
    name: 'Cafetera Espresso DeLonghi Dedica EC685',
    image: '',
    price: 85,
    salesperson: UserManager.users[3],
    stock: 24,
    freeDelivery: true,
    material: 'Acero inoxidable',
    brand: 'DeLonghi',
    description: 'Esta cafetera compacta y elegante permite preparar espressos y cappuccinos con calidad profesional. Cuenta con un sistema de calentamiento rápido y un espumador de leche ajustable para crear una espuma cremosa.'
  ),
  Product(
    name: 'Cafetera de Goteo Philips HD7435/20',
    image: '',
    price: 15,
    salesperson: UserManager.users[5],
    stock: 58,
    freeDelivery: false,
    material: 'Plástico y vidrio',
    brand: 'Philips',
    description: 'Ideal para preparar café filtrado, esta cafetera tiene una capacidad de 1.2 litros y un sistema antigoteo. Su diseño compacto la hace perfecta para cocinas pequeñas.'
  ),
  Product(
    name: 'Cafetera de Cápsulas Nespresso Inissia',
    image: '',
    price: 49,
    salesperson: UserManager.users[2],
    stock: 3,
    freeDelivery: false,
    material: 'Plástico',
    brand: 'Nespresso',
    description: 'Con un diseño compacto y ligero, esta cafetera de cápsulas es fácil de usar y ofrece una amplia variedad de sabores de café. Tiene un tiempo de calentamiento rápido y se apaga automáticamente después de 9 minutos de inactividad.'
  ),
  Product(
    name: 'Cafetera Italiana Bialetti Moka Express',
    image: '',
    price: 26,
    salesperson: UserManager.users[2],
    stock: 1,
    freeDelivery: true,
    material: 'Aluminio',
    brand: 'Bialetti',
    description: 'Clásica cafetera italiana que permite preparar un café fuerte y aromático. Es fácil de usar y limpiar, y su diseño icónico la convierte en un elemento decorativo en cualquier cocina.'
  ),
  Product(
    name: 'Molino de Café Krups GVX242',
    image: '',
    price: 194,
    salesperson: UserManager.users[1],
    stock: 16,
    freeDelivery: true,
    material: 'Acero inoxidable y plástico',
    brand: 'Krups',
    description: 'Este molino de café permite ajustar el grosor de la molienda para obtener el café perfecto. Tiene una capacidad de 200 gramos y un sistema de muelas cónicas que garantiza una molienda uniforme.'
  ),
];

class ShopPage extends StatefulWidget {
  const ShopPage({super.key, required this.title});
  final String title;

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
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
    setState(() { });
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
        title: Text(
          widget.title,
          style: const TextStyle(
            color: appBarTextColor
          )
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(30)),
                Icon(
                  size: 35,
                  Icons.shopping_cart
                ),
                Padding(padding: EdgeInsets.all(10))
              ],
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 350,
                maxHeight: 400
              ),
              child: CarouselView(
                scrollDirection: Axis.vertical,
                itemExtent: 100,
                onTap: (value) => {
                  products.remove(products[value])
                },
                children: List<Widget>.generate(products.length, (int index) {
                  return generateCard(index);
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
              FilledButton(onPressed: _goToHomePage, style: defaultButton, child: const Icon(Icons.home_outlined)), //Home button
              const SizedBox(width: spaceBetweenButtons),
              FilledButton(onPressed: _goToSearchPage, style: defaultButton, child: const Icon(Icons.search_outlined)), //Search button
              const SizedBox(width: spaceBetweenButtons),
              FilledButton(onPressed: _goToShopPage, style: selectedButton, child: const Icon(Icons.shop)), //Shop button
              const SizedBox(width: spaceBetweenButtons),
              FilledButton(onPressed: _goToProfilePage, style: defaultButton, child: const Icon(Icons.person_outline)), //Profile button
            ],
          )
        )
      ],
    );
  }

  Widget generateCard(int index) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: const Color.fromARGB(255, 163, 128, 104),
      child: Row(
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          const SizedBox( // Product image.
            height: 75,
            width: 75,
            // child: Image.asset(''),
          ),
          const SizedBox(width: 15,), // Space between recipe image and info.
          Column( // Info: recipe name and publish date.
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cutText(products[index].name, 20)),
              Text('${products[index].price} US')
            ],
          ),
          const SizedBox(width: 15),
          TextButton(
            onPressed: _goToHomePage,
            child: const Icon(Icons.shopping_cart_checkout),
          )
        ],
      ),
    );
  }

  // Return the text cut to the specified number of characters.
  String cutText(String text, int size) {
    String auxText = '';

    for (int i = 0; i < size; i++) {
      auxText += text[i];
    }

    return '$auxText...';
  }
}
