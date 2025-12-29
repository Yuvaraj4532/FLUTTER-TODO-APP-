import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _volume = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('icon Button')),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: IconButton(
              icon: Icon(Icons.volume_up),
              iconSize: 50.0,
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  _volume += 10;
                });
              },
            ),
          ),
          Text('Volume:${_volume}', style: TextStyle(fontSize: 25.0)),
        ],
      ),
    );
  }
}
