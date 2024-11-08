
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Question {
  final String title;
  final int value;
  final String minText;
  final String maxText;

  int min = 0;
  int max = 0;
  int rating = 0;

  Question({
    required this.title,
    required this.value,
    required this.minText,
    required this.maxText
  }) {
    min = int.parse(minText[0]);
    max = int.parse(maxText[0]);
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      title: map['title'],
      value: map['value'],
      minText: map['min'],
      maxText: map['max']
    );
  }

  static Future<List<Question>> loadYourOpinionQuestions() async {
    final jsonString = await rootBundle.loadString('assets/json/your_opinion_questions_simple.json');
    // final jsonString = await rootBundle.loadString('assets/json/your_opinion_questions.json');
    // final jsonString = await rootBundle.loadString('assets/json/my_barista_recipes.json');
    // final Map<String, dynamic> jsonDecoded = jsonDecode(jsonString) as Map<String, dynamic>;
    final List<dynamic> jsonDecoded = jsonDecode(jsonString) as List<dynamic>;
    print("test----:"+jsonDecoded.toString());
    // return jsonDecoded.entries.map((entry) => Question.fromMap(entry.value as Map<String, dynamic>)).toList();
    return jsonDecoded.map((dynamic item) => Question.fromMap(item as Map<String, dynamic>)).toList();
  }

  // Get customize card.
  // star pressed function is used to implement an algorithm that simulate 5-star-rating-system.
  Widget getCard(BuildContext context, Function(int) starPressed) {
    return Card(
      color: const Color(0xFFEFBE7F),
      child: Column(
        children: [
          Padding( // Display question.
            padding: const EdgeInsets.all(16.0),
            child: Text(title)
          ),
          Row( // Display 5-star buttons.
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) { // Generate 5 stars.
              return IconButton( // Star button.
                onPressed: () {
                  starPressed(index + 1); // Pass star number.
                },
                icon: rating > index ? // Customize stars color and shape to simulate 5-star-rating system.
                  Icon(
                    Icons.star,
                    color: _getColorByIndex(index)
                  )
                :
                  const Icon(
                    Icons.star_border,
                    color: Color(0xFF515151),
                  )
              );
            }),
          )
        ],
      )
    );
  }

  // Get star progressive colors.
  Color _getColorByIndex(int index) {
    return index == 0 ? const Color(0xFFC5B4A2) :
           index == 1 ? const Color(0xFF92785D) :
           index == 2 ? const Color(0xFF815F3B) :
           index == 3 ? const Color(0xFF6F471C) :
           /*index == 4*/const Color(0xFF4E2C08);
  }
}
