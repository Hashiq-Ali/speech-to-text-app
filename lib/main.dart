import 'package:flutter/material.dart';
import 'package:sample_project/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      color: Colors.teal,
      theme: ThemeData(
        // primarySwatch: Colors.blue,

        // // Set text color globally
        // textTheme: const TextTheme(
        //   bodyMedium: TextStyle(color: Colors.black), // Default text color
        //   bodyLarge: TextStyle(color: Colors.black), // Large body text
        //   titleLarge: TextStyle(color: Colors.blue), // Title text style
        // ),

        // // Set icon color globally
        // iconTheme: const IconThemeData(
        //   color: Colors.white, // Default icon color
        //   // Default icon size
        // ),

        // Set AppBar text and icon color
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // AppBar background color
          iconTheme: IconThemeData(color: Colors.white), // AppBar icon color
          titleTextStyle: TextStyle(
            color: Colors.white, // AppBar title color
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
