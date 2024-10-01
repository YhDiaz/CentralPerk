import 'package:central_perk/models/coffe_bean_type.dart';
import 'package:central_perk/models/comment.dart';
import 'package:central_perk/models/product.dart';
import 'package:central_perk/models/recipe_visibility.dart';
import 'package:central_perk/models/user.dart';

class Recipe {
  static int globalId = 0;
  String id = '';

  final String name;
  final DateTime date;
  final User owner;
  final List<String> ingredients = List.empty(growable: true);
  final double time;
  final String description;
  final String steps;
  final String image;
  final RecipeVisibility visibility;
  final List<String> tags = List.empty(growable: true);
  final List<Comment> comments = List.empty(growable: true);
  final List<Product> artifacts = List.empty(growable: true);
  final CoffeBeanType coffeBean;
  
  double rating = 1.0;
  int likes = 0;
  bool favorite;
  
  Recipe({
    required this.name,
    required this.date,
    required this.owner,
    required this.time,
    required this.description,
    required this.steps,
    required this.image,
    required this.visibility,
    required this.coffeBean,
    this.rating = 1.0,
    this.likes = 0,
    this.favorite = false
  })
  {
    globalId++;
    id = name + globalId.toString();
  }

  void setFav(bool value) {
    favorite = value;

    // Make changes in owner favorite recipes list.
    if (favorite) {
      owner.markRecipeAsFav(this);
    } else {
      owner.removeFromFav(this);
    }
  }

  String printIngredients() {
    String ingredientsMessage = '';

    for (int i = 0; i < ingredients.length; i++) {
      ingredientsMessage += '${i + 1}: ${ingredients[i]}\n';
    }

    return (ingredientsMessage == '') ? 
            'There are no ingredients for this recipe.' :
            ingredientsMessage;
  }

  String printArtifacts() {
    String artifactsMessage = '';

    for (int i = 0; i < artifacts.length; i++) {
      artifactsMessage += '${i + 1}: ${artifacts[i].name}\n';
    }

    return (artifactsMessage == '') ? 
            'You don\'t need any artifacts for this recipe.' :
            artifactsMessage;
  }

  String printComments() {
    String commentsMessage = '';

    for (int i = 0; i < comments.length; i++) {
      commentsMessage += '${comments[i].owner.name} - ${comments[i].date.day}/${comments[i].date.month}/${comments[i].date.year}\n${comments[i].comment}\n';
    }

    return (commentsMessage == '') ? 
            'There aren\'t any comments for this recipe.' :
            commentsMessage;
  }
}