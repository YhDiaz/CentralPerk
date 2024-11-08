import 'package:central_perk/models/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class YourOpinionPage extends StatefulWidget {
  const YourOpinionPage({super.key});

  @override
  State<YourOpinionPage> createState() => _YourOpinionPageState();
}

class _YourOpinionPageState extends State<YourOpinionPage> {
  // Send email using flutter_email_sender package.
  Future<void> _sendEmail() async {
    final Email email = Email(
            body: 'Test successful, direct to spam.',
            subject: 'Testing email sender package',
            recipients: ['yhdiazofficial@gmail.com'],
            isHTML: false,
          );

    await FlutterEmailSender.send(email);
  }

  Future<List<Question>>? _questionsFuture;
  List<Question> _questions = [];

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _questions = _buildYourOpinionQuestionsList();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _questionsFuture = Question.loadYourOpinionQuestions();
    });
  }

  List<Question> _buildYourOpinionQuestionsList() {
    if (_questionsFuture == null) {
      return []; // Return an empty list of questions.
    }
    _questionsFuture!.then((result) {
      for (var item in result) {
        _questions.add(item); // Add each question in questions future to list of questions.
      }
    });
    return _questions;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<Question>>(
        future: _questionsFuture, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
          Widget questionsList = _getQuestionsListToDisplay(true); // Base Widget.

          if (snapshot.hasData) questionsList = _getQuestionsListToDisplay(false); // List of recipes.

          return Scaffold(
            appBar: AppBar(
              title: const Text('Tu opinión'),
            ),
            body: questionsList,
            // body: const Center(
            //   child: Text('Preguntas')
            // ),
            floatingActionButton: FloatingActionButton(
              onPressed: _sendEmail,
              child: const Icon(Icons.email)
            ),
          );
        },
      ),
    );
  }

  Widget _getQuestionsListToDisplay(bool defaultInfo) {
    return Center(
      child: Column(
              children: [
                Expanded( // To avoid problems due to include a ListView inside a Column.
                  child: SizedBox(
                    width: 350.0, // Width of list items.
                    child: ListView.builder(
                      itemCount: _questions.length,
                      itemBuilder: (context, index) {
                        return defaultInfo ?
                          Text('No se encontró información de la receta $index') // Questions aren't loaded yet.
                        :
                          _questions[index].getCard(context); // Display question card.
                      },
                    )
                  ),
                )
              ],
            ),
    );
  }
  
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Tu opinión'),
  //     ),
  //     body: const Center(
  //       child: Text('Preguntas')
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: _sendEmail,
  //       child: const Icon(Icons.email)
  //     ),
  //   );
  // }
}