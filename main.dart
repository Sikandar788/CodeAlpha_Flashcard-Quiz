import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Quiz',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
