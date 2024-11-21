import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Controllers for input fields
  final TextEditingController firstNumController = TextEditingController();
  final TextEditingController secondNumController = TextEditingController();

  // Current result
  String result = "0";

  // Function to perform calculation
  void calculate(String operation) {
    // Parse input values
    double? firstNum = double.tryParse(firstNumController.text);
    double? secondNum = double.tryParse(secondNumController.text);

    if (firstNum == null || secondNum == null) {
      setState(() {
        result = "!INVALID!";
      });
      return;
    }

    // Perform the calculation based on the operation
    double calcResult;
    switch (operation) {
      case '+':
        calcResult = firstNum + secondNum;
        break;
      case '-':
        calcResult = firstNum - secondNum;
        break;
      case '*':
        calcResult = firstNum * secondNum;
        break;
      case '/':
        if (secondNum == 0) {
          setState(() {
            result = "Cannot be divided by zero!";
          });
          return;
        }
        calcResult = firstNum / secondNum;
        break;
      default:
        calcResult = 0;
    }

    // Update the result state
    setState(() {
      result = calcResult.toString();
    });
  }

  // Clear inputs and result
  void clear() {
    setState(() {
      firstNumController.clear();
      secondNumController.clear();
      result = "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Input fields
            TextField(
              controller: firstNumController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter First Number",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: secondNumController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter Second Number",
              ),
            ),
            const SizedBox(height: 20),

            // Result display
            Text(
              "Result: $result",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Buttons for operations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: const Text("+"),
                ),
                ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: const Text("-"),
                ),
                ElevatedButton(
                  onPressed: () => calculate('*'),
                  child: const Text("*"),
                ),
                ElevatedButton(
                  onPressed: () => calculate('/'),
                  child: const Text("/"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Clear button
            ElevatedButton(
              onPressed: clear,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              child: const Text(
                "Clear",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
