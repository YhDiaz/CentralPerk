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
            body: _generateEmailBody(),
            subject: 'Mi opinión sobre Central Perk',
            recipients: ['yhdiazofficial@gmail.com'],
            isHTML: false,
          );

    await FlutterEmailSender.send(email);
  }

  String _generateEmailBody() {
    String body = '¡Hola! Estas son mis respuestas sobre tu aplicación:\n\n';
    int finalRating = 0;
    
    for (var question in _questions) {
      body += question.title;
      body += '\n';
      body += question.rating.toString() + '/5';
      body += '\n\n';
      finalRating += question.rating;
    }

    body += 'Resultado final $finalRating/45, ';
    if (finalRating < 15) body += 'si fuera tú, me cambio de carrera a una en la que tenga futuro.';
    else if (finalRating < 25) body += 'un poco lamentable, pero que se le va a hacer.';
    else if (finalRating < 35) body += 'con un poco más de ganas la haces.';
    else if (finalRating < 42) body += 'te quedó buena, pero plagiaste el nombre.';
    else body += 'a la tienda y que genere :\$\$.';

    body += '\n\nMis datos:\n- Nombre: $name\n- Ocupación: $occupation\n- Relación con el desarrollador: $relationship';

    body += '\n\n* Respuesta generada automáticamente con un algoritmo de generación de respuestas';
    return body;
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
              title: Row(
                children: [
                  Text(
                    'Tu opinión',
                    style: Theme.of(context).textTheme.headlineLarge
                  ),
                  const SizedBox(width: 97,),
                  Image.asset(
                    'assets/icons/icon_central_perk_logo.png',
                    fit: BoxFit.contain,
                    height: 75,
                  ),
                ],
              ),
            ),
            body: questionsList,
            floatingActionButton: _allQuestionsRated() ?
              FloatingActionButton( // All questions were rated, then send email.
                onPressed: _sendEmail,
                child: const Icon(Icons.email),
                backgroundColor: const Color(0xFF7C5635),
              )
            :
              FloatingActionButton( // All questions were rated, then send email.
                backgroundColor: Color(0x95646464),
                onPressed: () {},
                child: const Icon(
                  Icons.email,
                  color: Color(0xFFCFCDCD),
                )
              )
          );
        },
      ),
    );
  }

  bool _allQuestionsRated() {
    for (var question in _questions) {
      if (question.rating == 0) return false;
    }

    return true && register;
  }

  // Update rating in an specific question, which is accessed using its index.
  void _updateRating(int index, int rating) {
    setState(() {
      _questions[index].rating = rating;
    });
  }

  String name = '';
  String relationship = '';
  String occupation = '';
  bool register = false;

  final _nameController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _occupationController = TextEditingController();

  Widget _getQuestionsListToDisplay(bool defaultInfo) {
    return Center(
      child: Column(
              children: [
                const SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: Theme.of(context).textTheme.bodyLarge
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextField(
                    controller: _occupationController,
                    decoration: InputDecoration(
                      hintText: '(Estudiante IDVRV, Cursando Programación para Dispositivos Móviles, No pertenece a la carrera)',
                      hintStyle: const TextStyle(fontSize: 12, height: 1.75, fontFamily: 'Montserrat', color: Color(0xFF794024)),
                      hintMaxLines: 3,
                      labelText: 'Ocupación',
                      labelStyle: Theme.of(context).textTheme.bodyLarge
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextField(
                    controller: _relationshipController,
                    decoration: InputDecoration(
                      hintText: '(Familiar, amigo, etc.)',
                      hintStyle: const TextStyle(fontSize: 12, height: 1.75, fontFamily: 'Montserrat', color: Color(0xFF794024)),
                      hintMaxLines: 3,
                      labelText: 'Relación con el desarrollador',
                      labelStyle: Theme.of(context).textTheme.bodyLarge
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      name = _nameController.text;
                      occupation = _occupationController.text;
                      relationship = _relationshipController.text;
                      register = true;
                      ScaffoldMessenger.of(context).showSnackBar( // Display message at the bottom of the screen.
                        const SnackBar(
                          content: Text(
                            'Te has registrado correctamente',
                            style: TextStyle(
                              color: Color(0xFFE7D0AE)
                            ),
                          ),
                          backgroundColor: Color(0xFF7C5635),
                        )
                      );
                    });
                  },
                  child: Text('Registrarse', style: Theme.of(context).textTheme.bodyMedium,),
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Color.fromARGB(255, 201, 168, 115))
                  ),
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  width: 350.0, // Width of list items.
                  height: 350.0,
                  child: ListView.builder(
                    itemCount: _questions.length, // Amount of items.
                    itemBuilder: (context, index) {
                      return defaultInfo ?
                        Text('No se encontró información de la pregunta $index') // Questions aren't loaded yet.
                      :
                        _questions[index].getCard(context, (rating) { // Display question card.
                          _updateRating(index, rating);
                        });
                    },
                  )
                ),
              ],
            ),
    );
  }
}