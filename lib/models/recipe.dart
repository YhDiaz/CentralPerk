import 'dart:ffi';
import 'package:central_perk/models/coffe_bean_type.dart';
import 'package:central_perk/models/recipe_visibility.dart';
import 'package:central_perk/models/user.dart';

class Recipe
{
  final String name;
  final Int8 id;
  final User owner;
  final List<String> ingredients = List.empty(growable: true);
  final Float? rating;
  final Float time;
  final String description;
  final String image;
  final RecipeVisibility visibility;
  final List<String> tags = List.empty(growable: true);
  final List<String> recomendations = List.empty(growable: true);
  final List<String> comments = List.empty(growable: true);
  // final List<Product> artifacts = List.empty(growable: true);
  final CoffeBeanType coffeBean;
  
  Recipe
  ({
    required this.name,
    required this.id,
    required this.owner,
    this.rating,
    required this.time,
    required this.description,
    required this.image,
    required this.visibility,
    required this.coffeBean
  });
}