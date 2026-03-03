import 'package:flutter/material.dart';

void main() {
  // Entry point of the Flutter app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Root widget of the app
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      home: RegistrationScreen(),        // Sets the main screen
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Stores the selected date from the DatePicker
  DateTime? selectedDate;

  // Controller for the name input field
  final TextEditingController nameController = TextEditingController();

  // Function to show the DatePicker and select a date
  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),        // Default date shown when picker opens
      firstDate: DateTime(1950),          // Earliest selectable date
      lastDate: DateTime.now(),           // Latest selectable date (today)
    );

    if (picked != null) {
      // Update the selected date in the state so UI updates
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Function to handle form submission
  void submitForm() {
    String name = nameController.text.trim(); // Get trimmed name input

    // Validate name field
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your name")),
      );
      return;
    }

    // Validate date selection
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select your date of birth")),
      );
      return;
    }

    // Show confirmation message with entered name and selected date
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Submitted: $name, DOB: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
        ),
      ),
    );

    // Log form data to console (useful for debugging)
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
            // Name input label
            const Text(
              "Enter Your Name",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),

            // TextField for entering name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Your name",
              ),
            ),
            const SizedBox(height: 30),

            // Display selected date or placeholder text
            Text(
              selectedDate == null
                  ? "No Date of Birth Selected"
                  : "Selected DOB: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),

            // Button to open DatePicker
            ElevatedButton(
              onPressed: pickDate, // Calls the function to pick a date
              child: const Text("Select Date of Birth"),
            ),
            const SizedBox(height: 30),

            // Submit button to validate and send form data
            ElevatedButton(
              onPressed: submitForm, // Calls the function to submit the form
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