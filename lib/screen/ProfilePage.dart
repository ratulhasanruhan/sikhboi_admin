import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import '../main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
        })
      ],
    );
  }
}
