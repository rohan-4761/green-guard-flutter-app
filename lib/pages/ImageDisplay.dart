import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chatScreen.dart';
import 'login_page.dart';

class ImageDisplayPage extends StatelessWidget {
  final String imagePath;

  const ImageDisplayPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Display'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.file(
                  File(imagePath),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    // User is logged in, navigate to ChatScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatScreen()),
                    );
                  } else {
                    // If not logged in, navigate to login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginForm()),
                    );
                  }

                },
                child: const Text('Talk to Chatbot'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
