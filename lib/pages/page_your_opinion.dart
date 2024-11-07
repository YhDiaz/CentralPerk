import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class YourOpinionPage extends StatefulWidget {
  const YourOpinionPage({super.key});

  @override
  State<YourOpinionPage> createState() => _YourOpinionPageState();
}

class _YourOpinionPageState extends State<YourOpinionPage> {
  Future<void> _sendEmail() async {
    final Email email = Email(
            body: 'Test successful, direct to spam.',
            subject: 'Testing email sender package',
            recipients: ['yhdiazofficial@gmail.com'],
            // cc: ['cc@example.com'],
            // bcc: ['bcc@example.com'],
            // attachmentPaths: ['/path/to/attachment.zip'],
            isHTML: false,
          );

          await FlutterEmailSender.send(email);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu opinión'),
      ),
      body: Center(
        child: Text('Preguntas')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendEmail,
        child: Icon(Icons.email)
      ),
    );
  }
}