import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubcriptionScreen extends StatefulWidget {
  const SubcriptionScreen({super.key});

  @override
  State<SubcriptionScreen> createState() => _SubcriptionScreenState();
}

class _SubcriptionScreenState extends State<SubcriptionScreen> {

  final _emailController = TextEditingController();
  String message = '';

  Future<void> subscribe(String email) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/subscribe'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode == 200) {
      setState(() {
        message = 'Confirmation email sent. Please check your inbox.';
      });
    } else {
      setState(() {
        message = 'Failed to subscribe. ${response.body}';
        print(message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Forecast Subscription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                subscribe(_emailController.text);
              },
              child: const Text('Subscribe'),
            ),
            const SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}
