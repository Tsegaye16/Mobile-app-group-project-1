
//This is our main.dart
import 'package:flutter/material.dart';
import 'screens/User_registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserRegistration(),
    );
  }
}

