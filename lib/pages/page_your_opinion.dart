import 'package:flutter/material.dart';

class YourOpinionPage extends StatefulWidget {
  const YourOpinionPage({super.key});

  @override
  State<YourOpinionPage> createState() => _YourOpinionPageState();
}

class _YourOpinionPageState extends State<YourOpinionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu opinión'),
      ),
    );
  }
}