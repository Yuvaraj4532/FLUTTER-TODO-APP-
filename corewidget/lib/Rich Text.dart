import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rich Text'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: RichText(
          text: TextSpan(
            text: 'flutter programming language',
            style: TextStyle(
              color: Colors.purple,
              fontSize: 30.0,
              decorationStyle: TextDecorationStyle.solid,
              fontStyle: FontStyle.italic,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'mobile development',
                style: TextStyle(
                  color: Colors.orange,
                  decorationStyle: TextDecorationStyle.double,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
