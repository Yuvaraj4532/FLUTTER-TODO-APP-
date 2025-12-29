import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Form Field'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Your Name';
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(hintText: "Email"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Your Email ';
                }
              },
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                if (_formkey.currentState!.validate()) {}
              },
              child: Container(
                width: 60,
                height: 20,
                color: Colors.red,
                child: Text('submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
