// import 'package:corewidget/main.dart';
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
        title: Text('Custom Ink Icon'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Ink(
          decoration: ShapeDecoration(shape: CircleBorder()),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Colors.red,
            iconSize: 50.0,
          ),
        ),
      ),
    );
  }
}
