import 'package:central_perk/models/user.dart';

class Product {
  static int globalId = 0;
  String id = '';
  
  final String name;
  final String image;
  final double price;
  final User salesperson;
  final int stock;
  final bool freeDelivery;
  final String material;
  final String brand;
  final String description;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.salesperson,
    required this.stock,
    required this.freeDelivery,
    required this.material,
    required this.brand,
    required this.description
  }) {
    globalId++;
    id = name + globalId.toString();
  }
}