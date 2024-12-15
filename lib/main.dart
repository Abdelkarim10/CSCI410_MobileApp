import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart'; // this one is for copying to clipboard

void main() {
  runApp(DailyQuoteApp());
}

class DailyQuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuotePage(),
    );
  }
}

class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {


  // this is for categorizing the quotes
  final Map<String, List<String>> categorizedQuotes = {
    "Motivational": [
      "Believe you can and you're halfway there.",
      "Act as if what you do makes a difference. It does.",
      "Success is not how high you climb, but how you make a difference.",
    ],
    "Funny": [
      "I'm on a seafood diet. I see food and I eat it.",
      "Why don’t skeletons fight each other? They don’t have the guts.",
      "I’m reading a book on anti-gravity. It’s impossible to put down.",
    ],
    "Love": [
      "Love is composed of a single soul inhabiting two bodies.",
      "To love and be loved is to feel the sun from both sides.",
      "Love recognizes no barriers. It jumps hurdles and penetrates walls.",
    ],
  };

  String selectedCategory = "Motivational"; // Default category
  String currentQuote = "Select a category and get inspired!";


  // generates a random quote based on the chosen category
  void generateRandomQuote() {
    final random = Random();
    final quotes = categorizedQuotes[selectedCategory] ?? [];
    if (quotes.isNotEmpty) {
      setState(() {
        currentQuote = quotes[random.nextInt(quotes.length)];
      });
    }
  }

  // copying the quote to the clippboard
  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: currentQuote));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Quote copied to clipboard!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Quote"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              // the dropdown for selecting categories
              DropdownButton<String>(
                value: selectedCategory,
                items: categorizedQuotes.keys.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                    currentQuote = "Tap the button to get inspired!";
                  });
                },
              ),
              SizedBox(height: 20),

              // displaying the quote
              Text(
                currentQuote,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20),


              // the button that generates a new quote
              ElevatedButton(
                onPressed: generateRandomQuote,
                child: Text("New Quote"),
              ),
              SizedBox(height: 10),
              // Copy to Clipboard Button
              ElevatedButton(
                onPressed: copyToClipboard,
                child: Text("Copy Quote"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
