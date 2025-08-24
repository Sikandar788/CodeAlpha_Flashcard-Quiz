import 'package:flutter/material.dart';
import 'flashcard.dart';
import 'flashcard_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Flashcard> flashcards = [
    Flashcard(question: 'What is Flutter?', answer: 'A UI toolkit by Google.'),
    Flashcard(question: 'What language is used in Flutter?', answer: 'Dart'),
    Flashcard(
      question: 'What widget is used for layouts in Flutter?',
      answer: 'Column and Row widgets.',
    ),
    Flashcard(
      question: 'Which method is called when a StatefulWidget is created?',
      answer: 'initState()',
    ),
    Flashcard(
      question: 'What is the purpose of setState()?',
      answer: 'To update the UI when data changes.',
    ),
  ];

  int currentIndex = 0;
  bool showAnswer = false;

  void _addFlashcard(String question, String answer) {
    setState(() {
      flashcards.add(Flashcard(question: question, answer: answer));
    });
  }

  void _editFlashcard(int index, String question, String answer) {
    setState(() {
      flashcards[index].question  = question;
      
      flashcards[index].answer = answer;
    });
  }

  void _deleteFlashcard(int index) {
    setState(() {
      if (flashcards.length > 1) {
        flashcards.removeAt(index);
        currentIndex = currentIndex.clamp(0, flashcards.length - 1);
      }
    });
  }

  void _showAddDialog() {
    String question = '', answer = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Flashcard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Question'),
              onChanged: (value) => question = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Answer'),
              onChanged: (value) => answer = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (question.isNotEmpty && answer.isNotEmpty) {
                _addFlashcard(question, answer);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog() {
    String question = flashcards[currentIndex].question;
    String answer = flashcards[currentIndex].answer;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Flashcard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: question),
              decoration: const InputDecoration(labelText: 'Question'),
              onChanged: (value) => question = value,
            ),
            TextField(
              controller: TextEditingController(text: answer),
              decoration: const InputDecoration(labelText: 'Answer'),
              onChanged: (value) => answer = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _editFlashcard(currentIndex, question, answer);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flashcard = flashcards[currentIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 78, 117, 109),
      appBar: AppBar(
        title: const Text('Flashcard Quiz',style: TextStyle(color: Colors.blueGrey),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _showAddDialog, icon: const Icon(Icons.add)),
          IconButton(onPressed: _showEditDialog, icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () => _deleteFlashcard(currentIndex),
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlashcardWidget(
            question: flashcard.question,
            answer: flashcard.answer,
            showAnswer: showAnswer,
            onToggle: () => setState(() => showAnswer = !showAnswer),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: currentIndex > 0
                    ? () => setState(() {
                          currentIndex--;
                          showAnswer = false;
                        })
                    : null,
                    style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.lime,
                    disabledForegroundColor: Colors.blue  
                    
                    ),
                child: const Text('Previous'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.lime,
                  disabledForegroundColor: Colors.blue
                ),
                onPressed: currentIndex < flashcards.length - 1
                    ? () => setState(() {
                          currentIndex++;
                          showAnswer = false;
                        })
                    : null,
                child: const Text('Next'),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
