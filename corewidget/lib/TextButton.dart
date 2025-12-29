import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Button')),
      body: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            overlayColor: Colors.amber,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),

          onPressed: () {},
          child: Text('click me'),
        ),
      ),
    );
  }
}
