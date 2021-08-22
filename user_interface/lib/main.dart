import 'package:flutter/material.dart';
import 'package:user_interface/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track IT',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
