// import 'dart:ffi';

import 'package:central_perk/models/user.dart';

class Product {
  static int globalId = 0;
  final String name;
  // final Int8 id;
  String id = '';
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
    // required this.id,
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