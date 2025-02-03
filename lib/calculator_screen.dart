import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _controller = TextEditingController();
  String results = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('String Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter a string',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  try {
                    final input = _controller.text;
                    final result = add(input);
                    setState(() {
                      results = result.toString();
                    });
                  } catch (e) {
                    setState(() {
                      results = e.toString();
                    });
                  }
                },
                child: const Text("Calculate")),
            const SizedBox(height: 10),
            Text("Results: $results")
          ],
        ),
      ),
    );
  }
}

int add(String numbers) {
  RegExp regExp = RegExp(r'-?\d+');
  Iterable<Match> matches = regExp.allMatches(numbers);
  if (matches.isEmpty) {
    return 0;
  }
  List<String> numbersOp = matches.map((match) => match.group(0)!).toList();
  List<int> negativeNumbers =
      numbersOp.map((e) => int.parse(e)).where((e) => e < 0).toList();
  if (negativeNumbers.isNotEmpty) {
    throw Exception(
        "Negative numbers not allowed: ${negativeNumbers.join(', ')}");
  }
  List<int> numberList = numbersOp.map((e) => int.parse(e)).toList();
  int sum = numberList.reduce((a, b) => a + b);
  return sum;
}
