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
      appBar: AppBar(
        title: Text('Image'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
          height: 300,
          width: double.infinity,
          color: Colors.lightBlueAccent,
          child: Image(image: AssetImage('Images/img2.jpg'), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
