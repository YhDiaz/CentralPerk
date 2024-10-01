import 'package:central_perk/models/recipe.dart';

class User {
  static int globalId = 0;
  String id = '';
  String username = '';

  final String name;
  final String password;
  final String profileImage;
  final List<User> friends = List.empty(growable: true);
  List<Recipe> myRecipes = List.empty(growable: true);
  final List<Recipe> savedRecipes = List.empty(growable: true);
  final List<Recipe> favoriteRecipes = List.empty(growable: true);
  final List<Recipe> sharedRecipes = List.empty(growable: true);

  User({
    required this.name,
    required this.username,
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
    username = '@$username';
  }

  int friendsCount() {
    return friends.length;
  }

  int recipesCount() {
    return myRecipes.length;
  }

  void sentFriendRequest(User friend) {

  }

  void addFriend(User friend) {
    if (!friends.contains(friend)) {
      friends.add(friend);
      friend.friends.add(this);
    }
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
      recipe.favorite = true;
    }
  }

  void removeFromFav(Recipe recipe) {
    // The recipe is in favoriteRecipes.
    if (favoriteRecipes.contains(recipe)) {
      favoriteRecipes.remove(recipe);
      recipe.favorite = false;
    }
  }

  void shareRecipe(String recipeName) {

  }

  void removeRecipe(Recipe recipe) {
    if (myRecipes.contains(recipe)) {
      myRecipes.remove(recipe);
    }
  }

  int likesCount() {
    int likes = 0;
    
    for (int i = 0; i < myRecipes.length; i++) {
      likes += myRecipes[i].likes;
    }

    return likes;
  }

  double averageRating() {
    double sum = 0;

    for (int i = 0; i < recipesCount(); i++) {
      sum += myRecipes[i].rating;
    }

    return (sum / recipesCount());
  }

  void removeFriend(User friend) {
    if (friends.contains(friend)) {
      friends.remove(friend);
      friend.friends.remove(this);
    }
  }
}