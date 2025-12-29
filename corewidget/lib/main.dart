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
        title: Center(child: Text('Row Widgets')),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.grey,
        height: 1000,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            //   Container(color: Colors.amber, height: 100, width: 100),
            //   Container(color: Colors.green, height: 100, width: 100),
            //   Container(color: Colors.pinkAccent, height: 100, width: 100),
            Text('Text_Widget', style: TextStyle(fontSize: 30.0)),
            Text('texxBaseline'),
          ],
        ),
      ),
    );
  }
}
