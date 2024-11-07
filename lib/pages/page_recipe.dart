import 'package:central_perk/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  final bool fromMyBarista;

  RecipePage({required this.recipe, this.fromMyBarista = false});

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( // Recipe info.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  widget.recipe.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.recipe.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              widget.recipe.description,
              style: TextStyle(fontSize: 16, color: Color(0xFF794024)),
            ),
          ],
        ),
      ),
      floatingActionButton: widget.fromMyBarista ?
        FloatingActionButton(
          onPressed: () {
            // Poner la funcionalidad para mover a mis receta, hay que ver bien si se necesita la database xq hay que agregar el bool de que pertenece al barista
          },
          child: Icon(Icons.add)
        )
      :
        null
    );
  }
}
