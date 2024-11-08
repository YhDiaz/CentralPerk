
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

  Widget getCard(BuildContext context) {
    return Card(
      child: Text(title),
    );
  }
}
