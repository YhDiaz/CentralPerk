// import 'dart:ffi';

import 'dart:ffi';

import 'package:central_perk/models/recipe.dart';

class User {
  static int globalId = 0;
  final String name;
  final String password;
  final String profileImage;
  String id = '';
  final List<User> friends = List.empty(growable: true);
  final List<Recipe> myRecipes = List.empty(growable: true);
  final List<Recipe> savedRecipes = List.empty(growable: true);
  final List<Recipe> favoriteRecipes = List.empty(growable: true);
  final List<Recipe> sharedRecipes = List.empty(growable: true);

  User({
    required this.name,
    required this.password,
    required this.profileImage
  }) {
    globalId++;
    List<String> nameSplitted = name.split(' ');
    String idName = '';

    for (int i = 0; i < nameSplitted.length; i++) {
      idName += nameSplitted[i];
    }

    id = idName + globalId.toString();

    // id = name + globalId.toString();
    // id = name.split(" ")[0] + name.split(" ")[1] + globalId.toString();
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

  void addRecipe(Recipe recipe) {
    myRecipes.add(recipe);
  }

  void editRecipe(Recipe recipe) {

  }

  void markRecipeAsFav(Recipe recipe) {
    // The recipe is not in favoriteRecipes yet.
    if (!favoriteRecipes.contains(recipe)) {
      favoriteRecipes.add(recipe);
    }
  }

  void shareRecipe(String recipeName) {

  }

  void removeRecipe(Recipe recipe) {
    if (myRecipes.contains(recipe)) {
      myRecipes.remove(recipe);
    }
  }
}