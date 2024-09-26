import 'dart:ffi';
import 'package:central_perk/models/recipe.dart';

class User
{
  final String name;
  final String password;
  final Int8 id;
  final List<User> friends = List.empty(growable: true);
  final List<Recipe> myRecipes = List.empty(growable: true);
  final List<Recipe> savedRecipes = List.empty(growable: true);
  final List<Recipe> favoriteRecipes = List.empty(growable: true);
  final List<Recipe> sharedRecipes = List.empty(growable: true);

  User
  ({
    required this.name,
    required this.password,
    required this.id
  });
}