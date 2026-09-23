import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // Form controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Password visibility
  bool hidePassword = true;

  // Gender
  String? gender;

  // Courses
  bool machineLearning = false;
  bool fullStack = false;
  bool mobileApplication = false;

  // Tuition pricing constants
  final double baseTuition = 500.0;
  final double mlCost = 250.0;
  final double fullStackCost = 300.0;
  final double mobileCost = 200.0;

  // Calculate dynamic tuition fee
  double get totalTuition {
    double total = baseTuition;
    if (machineLearning) total += mlCost;
    if (fullStack) total += fullStackCost;
    if (mobileApplication) total += mobileCost;
    return total;
  }

  // Clear everything
  void clearForm() {
    setState(() {
      usernameController.clear();
      passwordController.clear();
      hidePassword = true;
      gender = null;
      machineLearning = false;
      fullStack = false;
      mobileApplication = false;
    });
  }

  // Always dispose controllers to prevent memory leaks
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Back!!!"),
        backgroundColor: Colors.grey[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Username
            const Text(
              "Username",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your username",
              ),
            ),
            const SizedBox(height: 20),

            // Password
            const Text(
              "Password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: passwordController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Enter your password",
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Gender
            const Text(
              "Gender",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio<String>(
                  value: "Male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
                const Text("Male"),
                const SizedBox(width: 20),
                Radio<String>(
                  value: "Female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
                const Text("Female"),
              ],
            ),
            const SizedBox(height: 20),

            // Courses
            const Text(
              "Courses",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: const Text("Machine Learning (+\$250)"),
              value: machineLearning,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  machineLearning = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Full-Stack Development (+\$300)"),
              value: fullStack,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  fullStack = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Mobile Application (+\$200)"),
              value: mobileApplication,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  mobileApplication = value ?? false;
                });
              },
            ),
            const SizedBox(height: 20),

            // Tuition Display
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Tuition:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$$totalTuition",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle form submission logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("Submit"),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: OutlinedButton(
                    onPressed: clearForm,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("Clear Form"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}