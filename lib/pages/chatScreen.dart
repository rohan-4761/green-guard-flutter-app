import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login_page.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final databaseRef = FirebaseDatabase.instance.ref('Chat');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _userMessage = TextEditingController();

  static const apiKey = "AIzaSyDokb3GFaY6EZsYnOr8JtImlrVda36GAtg";

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<Message> _messages = [];



  @override
  void initState() {
    super.initState();
    fetchChatHistory();
  }


  Future<void> fetchChatHistory() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return;
    }
    final userId = currentUser.uid;

    final userChatRef = databaseRef.child(userId);

    // Fetch user messages
    final userMessagesSnapshot = await userChatRef.child('User').once();
    final userMessages = userMessagesSnapshot.snapshot.value as Map<dynamic, dynamic>? ?? {};
    userMessages.forEach((key, value) {
      _messages.add(Message(
        isUser: true,
        message: value['message'],
        date: DateTime.parse(value['date']),
      ));
    });

    // Fetch bot messages
    final modelMessagesSnapshot = await userChatRef.child('Model').once();
    final modelMessages = modelMessagesSnapshot.snapshot.value as Map<dynamic, dynamic>? ?? {};
    modelMessages.forEach((key, value) {
      _messages.add(Message(
        isUser: false,
        message: value['message'],
        date: DateTime.parse(value['date']),
      ));
    });

    // Sort messages by date
    _messages.sort((a, b) => a.date.compareTo(b.date));


    setState(() {});
  }





  Future<void> sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    // Get the current user
    final currentUser = _auth.currentUser;
    if (currentUser == null) {

      return;
    }
    final userId = currentUser.uid;


    final userChatRef = databaseRef.child(userId);


    final userMessageRef = userChatRef.child('User').push();
    await userMessageRef.set({
      'isUser': true,
      'message': message,
      'date': DateTime.now().toIso8601String(),
    });

    setState(() {
      _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);


    final botMessageRef = userChatRef.child('Model').push();
    await botMessageRef.set({
      'isUser': false,
      'message': response.text ?? "",
      'date': DateTime.now().toIso8601String(),
    });

    setState(() {
      _messages.add(Message(isUser: false, message: response.text ?? "", date: DateTime.now()));
    });
  }


  Future<void> _logout() async {
    await _auth.signOut();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginForm()),
      );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gemini Chat Bot'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _logout,
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Messages(
                    isUser: message.isUser,
                    message: message.message,
                    date: DateFormat('HH:mm').format(message.date),
                  );
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      controller: _userMessage,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        label: const Text("Enter your message"),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(15),
                    iconSize: 30,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        const CircleBorder(),
                      ),
                    ),
                    onPressed: () {
                      sendMessage();
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            )
          ],
        ));
  }
}


class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const Messages(
      {super.key,
        required this.isUser,
        required this.message,
        required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
        color: isUser
            ? const Color.fromARGB(255, 9, 48, 79)
            : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
          topRight: const Radius.circular(10),
          bottomRight: isUser ? Radius.zero : const Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({
    required this.isUser,
    required this.message,
    required this.date,
  });
}