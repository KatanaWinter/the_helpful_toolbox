import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/login/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Helpful Toolbox',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
