import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  DateTime? selectedDate;
  final TextEditingController nameController = TextEditingController();

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void submitForm() {
    String name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your name")),
      );
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select your date of birth")),
      );
      return;
    }

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Submitted: $name, DOB: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
        ),
      ),
    );

    // Log to console
    print("Form submitted:");
    print("Name: $name");
    print("Date of Birth: $selectedDate");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Registration"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Your Name",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Your name",
              ),
            ),
            const SizedBox(height: 30),
            Text(
              selectedDate == null
                  ? "No Date of Birth Selected"
                  : "Selected DOB: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: pickDate,
              child: const Text("Select Date of Birth"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}