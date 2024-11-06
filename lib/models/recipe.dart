import 'package:central_perk/pages/page_recipe.dart';
import 'package:flutter/material.dart';

class Recipe {
  final String name;
  final String description;
  final String image;

  Recipe({
    required this.name,
    required this.description,
    required this.image
  });

  Widget getCard(BuildContext context) {
    return Column(
                      children: [
                        Card(
                          color: const Color(0xFFE0D0C0), // Card color.
                          elevation: 8,
                          margin: EdgeInsets.symmetric(vertical: 10), // Vertical margin.
                          child: InkWell( // To detect taps.
                            onTap: () { // Behavior when touch the recipe.
                              Navigator.push( // Add Recipe page to navigation stack.
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipePage(title: 'Receta'),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center( // Center image.
                                  child: ClipRRect( // Add recipe image with rounded borders.
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)), // Top card border.
                                    child: Image.asset(
                                      // recetas[index]['image']!,
                                      image,
                                      width: 350,
                                      height: 250,
                                      fit: BoxFit.cover, // To adjust image to container.
                                    ),
                                  ),
                                ),
                                Padding( // Recipe name.
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    // recetas[index]['name']!,
                                    name,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding( // Recipe content.
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    // recetas[index]['description']!,
                                    description,
                                    style: TextStyle(fontSize: 16, color: const Color(0xFF674722)),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 50,
                        //   color: Colors.amber[600],
                        //   child: Center(child: Text('Entry $index')),
                        // ),
                        // _getSpace('content_content')
                      ],
                    );
  }
}










// import 'package:central_perk/models/coffe_bean_type.dart';
// import 'package:central_perk/models/comment.dart';
// import 'package:central_perk/models/product.dart';
// import 'package:central_perk/models/recipe_visibility.dart';
// import 'package:central_perk/models/user.dart';

// class Recipe {
  
  // static int globalId = 0;
  // String id = '';

  // final String name;
  // final DateTime date;
  // final User owner;
  // final double time;
  // final String description;
  // final String steps;
  // final String image;
  // final RecipeVisibility visibility;
  // final CoffeBeanType coffeBean;
  
  // double rating = 1.0;
  // int likes = 0;
  // bool favorite;
  // List<String> ingredients = List.empty(growable: true);
  // List<String> tags = List.empty(growable: true);
  // List<Comment> comments = List.empty(growable: true);
  // List<Product> artifacts = List.empty(growable: true);
  
  // Recipe({
  //   required this.name,
  //   required this.date,
  //   required this.owner,
  //   required this.time,
  //   required this.description,
  //   required this.steps,
  //   required this.image,
  //   required this.visibility,
  //   required this.coffeBean,
  //   this.rating = 1.0,
  //   this.likes = 0,
  //   this.favorite = false,
  // })
  // {
  //   globalId++;
  //   id = name + globalId.toString();
  // }

  // void setFav(bool value) {
  //   favorite = value;

  //   // Make changes in owner favorite recipes list.
  //   if (favorite) {
  //     owner.markRecipeAsFav(this);
  //   } else {
  //     owner.removeFromFav(this);
  //   }
  // }

  // String printIngredients() {
  //   String ingredientsMessage = '';

  //   for (int i = 0; i < ingredients.length; i++) {
  //     ingredientsMessage += '${i + 1}: ${ingredients[i]}\n';
  //   }

  //   return (ingredientsMessage == '') ? 
  //           'There are no ingredients for this recipe.' :
  //           ingredientsMessage;
  // }

  // String printArtifacts() {
  //   String artifactsMessage = '';

  //   for (int i = 0; i < artifacts.length; i++) {
  //     artifactsMessage += '${i + 1}: ${artifacts[i].name}\n';
  //   }

  //   return (artifactsMessage == '') ? 
  //           'You don\'t need any artifacts for this recipe.' :
  //           artifactsMessage;
  // }

  // String printComments() {
  //   String commentsMessage = '';

  //   for (int i = 0; i < comments.length; i++) {
  //     commentsMessage += '${comments[i].owner.name} - ${comments[i].date.day}/${comments[i].date.month}/${comments[i].date.year}\n${comments[i].comment}\n';
  //   }

  //   return (commentsMessage == '') ? 
  //           'There aren\'t any comments for this recipe.' :
  //           commentsMessage;
  // }

  // void initializeIngredients(List<String> ingredients) {
  //   this.ingredients = ingredients;
  // }

  // void initializeArtifacts(List<Product> artifacts) {
  //   this.artifacts = artifacts;
  // }

  // void initializeComments(List<Comment> comments) {
  //   this.comments = comments;
  // }
// }