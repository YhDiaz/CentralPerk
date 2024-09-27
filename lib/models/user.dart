// import 'dart:ffi';

import 'package:central_perk/models/recipe.dart';

class User {
  static int globalId = 0;
  final String name;
  final String password;
  final String profileImage;
  String id = '';
  // final Int8 id;
  final List<User> friends = List.empty(growable: true);
  final List<Recipe> myRecipes = List.empty(growable: true);
  final List<Recipe> savedRecipes = List.empty(growable: true);
  final List<Recipe> favoriteRecipes = List.empty(growable: true);
  final List<Recipe> sharedRecipes = List.empty(growable: true);

  User({
    required this.name,
    // required this.id,
    required this.password,
    required this.profileImage
  }) {
    globalId++;
    id = name + globalId.toString();
  }

  int friendsCount() {
    return friends.length;
  }

  int recipesCount() {
    return myRecipes.length;
  }

  void sentFriendRequest(User friend) {

  }

  void addFriend() {

  }

  void createRecipe() {

  }

  void editRecipe(String recipeName) {

  }

  void markRecipeAsFav(String recipeName) {

  }

  void shareRecipe(String recipeName) {

  }
}