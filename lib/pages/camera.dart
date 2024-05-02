import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ImageDisplay.dart';
import 'chatScreen.dart';
import 'login_page.dart';

class Cam extends StatefulWidget {
  const Cam({Key? key});

  @override
  _CamState createState() => _CamState();
}

class _CamState extends State<Cam> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? image;

  Future<void> _openCamera() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);
    _handleImage(pickedImage);
  }

  Future<void> _openGallery() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    _handleImage(pickedImage);
  }

  void _handleImage(XFile? pickedImage) {
    if (pickedImage != null) {
      // Navigate to a new page to display the image
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageDisplayPage(imagePath: pickedImage.path),
        ),
      );
    } else {
      print('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[700], // Grey color scheme
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Green Guard'),
        ),
        backgroundColor: Colors.grey[700],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _openCamera();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Text(
                  'Camera',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _openGallery,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Text(
                  'Upload From Gallery',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
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
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Text(
                  'Chat with Bot',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

