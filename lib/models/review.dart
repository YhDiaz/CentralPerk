import 'package:central_perk/models/user.dart';
import 'package:central_perk/models/recipe.dart';

class Review {
  static int globalId = 0;
  final DateTime date;
  final User owner;
  final String comment;
  final double rating;
  final User recipeOwner;
  final Recipe recipe;
  String id = '';

  Review({
    required this.date,
    required this.owner,
    required this.comment,
    required this.rating,
    required this.recipeOwner,
    required this.recipe
  })
  {
    globalId++;
    id = owner.name + date.toString();
  }

  void editReview(String comment, double rating) {

  }

  void deleteReview() {
    
  }
}