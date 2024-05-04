import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chatScreen.dart';
import 'login_page.dart';

class ImageDisplayPage extends StatefulWidget {
  final String imagePath;
  final String responseBody;

  const ImageDisplayPage({
    super.key,
    required this.imagePath,
    required this.responseBody,
  });

  @override
  _ImageDisplayPageState createState() => _ImageDisplayPageState();
}

class _ImageDisplayPageState extends State<ImageDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Image'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.file(
                  File(widget.imagePath),
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                '${widget.responseBody}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
                child: const Text(
                  'Talk to Chatbot',
                  style: TextStyle(
                    color: Colors.black,
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




// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'chatScreen.dart';
// import 'login_page.dart';
//
// class ImageDisplayPage extends StatelessWidget {
//   final String imagePath;
//   final String responseBody;
//
//
//   const ImageDisplayPage({
//     Key? key,
//     required this.imagePath,
//     required this.responseBody,
//   }) : super(key: key);
//
//   //
//   // const ImageDisplayPage({
//   //   Key? key,
//   //   required this.imagePath, required Float32List prediction,
//   // }) : super(key: key);
//
//   // const ImageDisplayPage({super.key, required this.imagePath, required Float32List prediction});
//
//
//
//   // get prediction => null;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Selected Image'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Image.file(
//                   File(imagePath),
//                   width: 300,
//                   height: 300,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(height: 25),
//                TextField(
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Prediction',
//                 ),
//                 controller: TextEditingController(text: widget.responseBody),
//
//
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   User? user = FirebaseAuth.instance.currentUser;
//                   if (user != null) {
//                     // User is logged in, navigate to ChatScreen
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const ChatScreen()),
//                     );
//                   } else {
//                     // If not logged in, navigate to login page
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const LoginForm()),
//                     );
//                   }
//
//                 },
//                 child: const Text('Talk to Chatbot',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
