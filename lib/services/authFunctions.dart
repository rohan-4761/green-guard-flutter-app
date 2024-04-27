import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import  'package:delightful_toast/delight_toast.dart';
import '../pages/chatScreen.dart';

class AuthServices {
  static signupUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(email);


      DelightToastBar(

        builder: (context) => const ToastCard(
          leading: Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          title: Text(
            'Registration Successful',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ).show(context);

      Future.delayed(const Duration(seconds: 7), () {
        DelightToastBar.removeAll();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ChatScreen()),
        );
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DelightToastBar(
          builder: (context) => const ToastCard(
            leading: Icon(
              Icons.warning,
              color: Colors.red,
            ),
            title: Text(
              'Password Provided is too weak',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ).show(context);
      } else if (e.code == 'email-already-in-use') {
        DelightToastBar(
          builder: (context) => const ToastCard(
            leading: Icon(
              Icons.warning,
              color: Colors.red,
            ),
            title: Text(
              'Email Provided already Exists',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ).show(context);
      }
    } catch (e) {
      DelightToastBar(
        builder: (context) => ToastCard(
          leading: const Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          title: Text(
            e.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ).show(context);
    }
  }

  static signinUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      DelightToastBar(
        builder: (context) => const ToastCard(
          leading: Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          title: Text(
            'You are Logged in',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ).show(context);

      Future.delayed(const Duration(seconds: 5), () {
        DelightToastBar.removeAll();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ChatScreen()),
        );
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        DelightToastBar(
          builder: (context) => const ToastCard(
            leading: Icon(
              Icons.warning,
              color: Colors.red,
            ),
            title: Text(
              'No user Found with this Email',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ).show(context);
      } else if (e.code == 'wrong-password') {
        DelightToastBar(
          builder: (context) => const ToastCard(
            leading: Icon(
              Icons.warning,
              color: Colors.red,
            ),
            title: Text(
              'Password did not match',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ).show(context);
      }
    }
  }
}

